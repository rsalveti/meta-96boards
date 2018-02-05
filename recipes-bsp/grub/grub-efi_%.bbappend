FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "\
	file://cfg.emmc \
	file://cfg.sdcard \
"

GRUB_BUILDIN_append ?= " chain configfile echo efinet eval font gettext gfxterm gzio help lsefi read regexp search_fs_file search_fs_uuid search_label terminal terminfo tftp time"

python () {
    grub_cfg = 'cfg'

    emmc = d.getVar('CMDLINE_ROOT_EMMC', True)
    sdcard = d.getVar('CMDLINE_ROOT_SDCARD', True)
    cmdline = d.getVar('CMDLINE', True)

    if emmc is not None and emmc in cmdline:
        grub_cfg = 'cfg.emmc'
    elif sdcard is not None and sdcard in cmdline:
        grub_cfg = 'cfg.sdcard'

    d.setVar('GRUB_CFG', grub_cfg)
}
