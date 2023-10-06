#!/usr/bin/env -S v

import cli
import os
import regex

const site_path = join_path(@VMODROOT, 'docs', 'site')

fn rm_readme_section(html string) string {
	mut r := regex.regex_opt(r'<section id="readme_dialog".*</section>') or { panic(err) }
	sec_start, sec_end := r.find(html)
	return '${html[..sec_start]}</section>${html[sec_end..]}'
		.replace('<li class="open"><a href="#readme_dialog">README</a></li>', '')
}

fn run(cmd cli.Command) ! {
	mut p := os.new_process(@VEXE)
	p.set_args(['doc', '-readme', '-m', '-f', 'html', '.'])
	p.set_work_folder(@VMODROOT)
	p.wait()
	rmdir_all(site_path) or {}
	mv('_docs', site_path)!
	module_html_path := join_path(site_path, 'dialog.html')
	mut module_html := read_file(module_html_path)!
	module_html = rm_readme_section(module_html)
	write_file(module_html_path, module_html)!
}

mut cmd := cli.Command{
	name: 'build.vsh'
	execute: run
}
cmd.parse(os.args)
