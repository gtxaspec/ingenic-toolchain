/EXP_ABSOLUTE_GCC_PREFIX/{
	s//'"${absolute_gcc_prefix}"'/g
	s/.*/echo '&'/e
}

/EXP_ABSOLUTE_GXX_PREFIX/{
	s//'"${absolute_gxx_prefix}"'/g
	s/.*/echo '&'/e
}

/EXP_SSHPORT/{
	s//'"${sshport}"'/g
	s/.*/echo '&'/e
}

/EXP_TARGETIP/{
	s//'"${targetip}"'/g
	s/.*/echo '&'/e
}

/EXP_CFLAGS/{
	s//'"${cflags}"'/g
	s/.*/echo '&'/e
}

/EXP_PATH/{
	s//'"${path}"'/g
	s/.*/echo '&'/e
}

/EXP_DEJAGNU_DIR/{
	s//'"${dejagnu_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_TOOLCHAIN_TARGET_INTERNAL/{
	s//'"${toolchain_target_internal}"'/g
	s/.*/echo '&'/e
}

/EXP_TOOLCHAIN_TARGET/{
	s//'"${toolchain_target}"'/g
	s/.*/echo '&'/e
}

/EXP_GDB_SRC_DIR/{
	s//'"${src_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_GAS_SRC_DIR/{
	s//'"${src_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_SRC_DIR/{
	s//'"${src_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_DEJAGNU_SPECIAL/{
	s//'"${dejagnu_special}"'/g
	s/.*/echo '&'/e
}

/EXP_OUT_DIR/{
	s//'"${out_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_RUN_DIR/{
	s//'"${run_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_OBJ_DIR/{
	s//'"${obj_dir}"'/g
	s/.*/echo '&'/e
}

/EXP_TOOL_EXEC/{
	s//'"${tool_exec}"'/g
	s/.*/echo '&'/e
}

/EXP_TOOL/{
	s//'"${tool}"'/g
	s/.*/echo '&'/e
}

/INSTALL_PATH/{
	s//'"${install_path}"'/g
	s/.*/echo '&'/e
}

/MULTILIB/{
	s//'"${multilib}"'/g
	s/.*/echo '&'/e
}