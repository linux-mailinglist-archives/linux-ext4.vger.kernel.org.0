Return-Path: <linux-ext4+bounces-7321-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86457A910F0
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 02:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987181907143
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 00:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A3617332C;
	Thu, 17 Apr 2025 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHiYt+zY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F276256D
	for <linux-ext4@vger.kernel.org>; Thu, 17 Apr 2025 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744851482; cv=none; b=AlRS7X5dHDXWIRicqIocGcy2FEaURFk4TojRpKe4yF28PGTlqFEe+x2F4FX78oe23FAZXsYginsVWKaXPMXylxUidNh2m80cbz9/5DoHhGTbXZOPkc64SrvwHOLgZlxkUseKQh6u8v3LHWoeEmCIpEhIa7GEviBmXzm13KreG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744851482; c=relaxed/simple;
	bh=cds5LmF+eYgrwxZUCn1wnSmKN1SC2WSf2H9o8iw+Tsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzahVJl6Di09nAgqDlPv7t++ropxgS84Q21akllcoeUEi/fLRYQLBITP4wmWeSpdR2vGjNtONsSnrTn8DO7Kak6o1VRu8MZk++/XQ16DF2tFmWbZ+3atyZyN5I29mu8dKruIVb3lbZLh6NaM/uD8/9tk9bQcYz24yvbszILTuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHiYt+zY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744851480; x=1776387480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cds5LmF+eYgrwxZUCn1wnSmKN1SC2WSf2H9o8iw+Tsc=;
  b=KHiYt+zYQgRNhoCMOk7G9ff8zz6uO8/fuxVKpkwUMxM1mrKEQ3WJKliV
   vkGBXPXXqschTBgtPstNgoiShR9xXBta3wBt4mf+/Ss2J+V7kjUucN9uh
   Bys/kB/eczYA1PMxCbxvMfHt1ZO9slg7Y/PzsTBV9OHMAOBC4+QbNHS3F
   jJd/l+XWEYU58EkynpeDCFO6oRXGruA3hIvKRt7eyoMAjwcPdv+q4sXui
   Vp/58ZLqyJB/2W0DZwV9jDX5ewLkWODu7J62EuXbRdJkRmOL2lvax75qo
   btOCmINUzMycJ09vNHl9yxgYXdSLKOtaKh8Yw8BW2jZoN9gQckXyPh34w
   A==;
X-CSE-ConnectionGUID: k+xNuliLTd2LySr1aBvXMw==
X-CSE-MsgGUID: Rd6n1NJtSV2fok+ZhoYjCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="56603717"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="56603717"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 17:57:59 -0700
X-CSE-ConnectionGUID: LwbkUvaqSn6euNmPBssx1A==
X-CSE-MsgGUID: HEkqJGDcQZOqnY6ds2tOGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="131549109"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 17:57:57 -0700
Date: Thu, 17 Apr 2025 08:58:36 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, yi1.lai@intel.com
Subject: Re: [PATCH v2 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Message-ID: <aABSPBONtvBFLihL@ly-workstation>
References: <20250208063141.1539283-1-yebin@huaweicloud.com>
 <20250208063141.1539283-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208063141.1539283-3-yebin@huaweicloud.com>

Hi Ye Bin,

Greetings!

I used Syzkaller and found that there is kernel BUG in ext4_update_inline_data in linux v6.15-rc2.

After bisection and the first bad commit is:
"
5701875f9609 ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250416_221056_ext4_update_inline_data
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250416_221056_ext4_update_inline_data/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250416_221056_ext4_update_inline_data/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250416_221056_ext4_update_inline_data/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250416_221056_ext4_update_inline_data/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250416_221056_ext4_update_inline_data/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250416_221056_ext4_update_inline_data/bzImage_5701875f9609b000d91351eaa6bfd97fe2f157f4
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250416_221056_ext4_update_inline_data/5701875f9609b000d91351eaa6bfd97fe2f157f4_dmesg.log

"
[   21.479561] ------------[ cut here ]------------
[   21.480014] kernel BUG at fs/ext4/inline.c:357!
[   21.480408] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   21.480918] CPU: 1 UID: 0 PID: 718 Comm: repro Tainted: G        W          6.14.0-rc2-5701875f9609+ #1
[   21.481634] Tainted: [W]=WARN
[   21.481882] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebui4
[   21.482739] RIP: 0010:ext4_update_inline_data+0x48c/0x500
[   21.483193] Code: 0f 84 cc fc ff ff e8 c3 c0 50 ff 4c 89 e7 e8 bb 80 db ff e9 ba fc ff ff 48 89 cf e8 3e f
[   21.484587] RSP: 0018:ff11000011637678 EFLAGS: 00010293
[   21.485002] RAX: 0000000000000000 RBX: 1fe22000022c6ed5 RCX: ffffffff82372a1f
[   21.485547] RDX: ff110000168dabc0 RSI: ffffffff82372cac RDI: 0000000000000005
[   21.486094] RBP: ff110000116377b0 R08: ffffffff85e27b00 R09: 0000000000000000
[   21.486640] R10: 00000000ffffffc3 R11: 1ffffffff11f3787 R12: ff1100001d937910
[   21.487312] R13: 000000000000080c R14: 00000000ffffffc3 R15: ff11000011637788
[   21.487867] FS:  00007f9610273740(0000) GS:ff1100006c900000(0000) knlGS:0000000000000000
[   21.488481] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.488931] CR2: 00007fffee66eed8 CR3: 0000000018d60004 CR4: 0000000000771ef0
[   21.489479] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   21.490027] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   21.490570] PKRU: 55555554
[   21.491092] Call Trace:
[   21.491310]  <TASK>
[   21.491493]  ? show_regs+0x6d/0x80
[   21.491780]  ? die+0x3c/0xa0
[   21.492044]  ? do_trap+0x230/0x410
[   21.492332]  ? do_error_trap+0xf2/0x210
[   21.492644]  ? ext4_update_inline_data+0x48c/0x500
[   21.493038]  ? handle_invalid_op+0x39/0x50
[   21.493370]  ? ext4_update_inline_data+0x48c/0x500
[   21.493758]  ? exc_invalid_op+0x63/0x80
[   21.494073]  ? asm_exc_invalid_op+0x1f/0x30
[   21.494417]  ? ext4_update_inline_data+0x1ff/0x500
[   21.495074]  ? ext4_update_inline_data+0x48c/0x500
[   21.495492]  ? ext4_update_inline_data+0x48c/0x500
[   21.495902]  ? ext4_update_inline_data+0x48c/0x500
[   21.496293]  ? __pfx_ext4_update_inline_data+0x10/0x10
[   21.496713]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   21.497145]  ? ext4_journal_check_start+0x23f/0x360
[   21.497538]  ext4_prepare_inline_data+0x1fa/0x260
[   21.497926]  ext4_generic_write_inline_data+0x1d5/0xaf0
[   21.498340]  ? __pfx_ext4_generic_write_inline_data+0x10/0x10
[   21.499087]  ? __this_cpu_preempt_check+0x21/0x30
[   21.499494]  ext4_da_write_begin+0x713/0x920
[   21.499866]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[   21.500262]  ? __pfx_ext4_da_write_begin+0x10/0x10
[   21.500649]  ? balance_dirty_pages_ratelimited_flags+0x9b/0x12a0
[   21.501129]  ? fault_in_iov_iter_readable+0x78/0x2e0
[   21.501530]  generic_perform_write+0x2f8/0x8f0
[   21.501904]  ? __pfx_generic_perform_write+0x10/0x10
[   21.502316]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   21.502796]  ? mnt_put_write_access_file+0x5c/0x110
[   21.503193]  ext4_buffered_write_iter+0x127/0x460
[   21.503572]  ext4_file_write_iter+0xb32/0x1ee0
[   21.503939]  ? lock_acquire+0x1cd/0x550
[   21.504253]  ? __pfx_ext4_file_write_iter+0x10/0x10
[   21.504642]  ? __this_cpu_preempt_check+0x21/0x30
[   21.505018]  ? lock_is_held_type+0xef/0x150
[   21.505360]  vfs_write+0xc60/0x1140
[   21.505651]  ? __pfx_ext4_file_write_iter+0x10/0x10
[   21.506044]  ? __pfx_vfs_write+0x10/0x10
[   21.506373]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   21.507075]  ksys_write+0x14f/0x280
[   21.507360]  ? __pfx_ksys_write+0x10/0x10
[   21.507700]  __x64_sys_write+0x7b/0xc0
[   21.508033]  x64_sys_call+0x16b3/0x2140
[   21.508349]  do_syscall_64+0x6d/0x140
[   21.508652]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   21.509059] RIP: 0033:0x7f961003ee5d
[   21.509348] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 8
[   21.511028] RSP: 002b:00007fff627878b8 EFLAGS: 00000287 ORIG_RAX: 0000000000000001
[   21.511634] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f961003ee5d
[   21.512201] RDX: 000000000000080c RSI: 0000200000001700 RDI: 0000000000000004
[   21.512751] RBP: 00007fff627878d0 R08: 0000000000000010 R09: 0000000000000010
[   21.513302] R10: 0000000000000000 R11: 0000000000000287 R12: 00007fff62787a48
[   21.513852] R13: 0000000000403757 R14: 0000000000406e08 R15: 00007f96102be000
[   21.514411]  </TASK>
[   21.514596] Modules linked in:
[   21.515293] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Sat, Feb 08, 2025 at 02:31:41PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
> Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172
> 
> CPU: 3 PID: 15172 Comm: syz-executor.0
> Call Trace:
>  __dump_stack lib/dump_stack.c:82 [inline]
>  dump_stack+0xbe/0xfd lib/dump_stack.c:123
>  print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
>  __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
>  kasan_report+0x3a/0x50 mm/kasan/report.c:585
>  ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
>  ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
>  ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
>  evict+0x39f/0x880 fs/inode.c:622
>  iput_final fs/inode.c:1746 [inline]
>  iput fs/inode.c:1772 [inline]
>  iput+0x525/0x6c0 fs/inode.c:1758
>  ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
>  ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
>  mount_bdev+0x355/0x410 fs/super.c:1446
>  legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
>  vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
>  do_new_mount fs/namespace.c:2983 [inline]
>  path_mount+0x119a/0x1ad0 fs/namespace.c:3316
>  do_mount+0xfc/0x110 fs/namespace.c:3329
>  __do_sys_mount fs/namespace.c:3540 [inline]
>  __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Memory state around the buggy address:
>  ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> Above issue happens as ext4_xattr_delete_inode() isn't check xattr
> is valid if xattr is in inode.
> To solve above issue call xattr_check_inode() check if xattr if valid
> in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
> so that there is no divergent verification.
> 
> Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/inode.c |  5 +++++
>  fs/ext4/xattr.c | 26 +-------------------------
>  fs/ext4/xattr.h |  7 +++++++
>  3 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..af735386aa44 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4674,6 +4674,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>  	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>  		int err;
>  
> +		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
> +					ITAIL(inode, raw_inode));
> +		if (err)
> +			return err;
> +
>  		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
>  		err = ext4_find_inline_data_nolock(inode);
>  		if (!err && ext4_has_inline_data(inode))
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 0e4494863d15..a10fb8a9d02d 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -308,7 +308,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
>  	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
>  
>  
> -static inline int
> +int
>  __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
>  			 void *end, const char *function, unsigned int line)
>  {
> @@ -316,9 +316,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
>  			    function, line);
>  }
>  
> -#define xattr_check_inode(inode, header, end) \
> -	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
> -
>  static int
>  xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
>  		 void *end, int name_index, const char *name, int sorted)
> @@ -650,9 +647,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
>  	end = ITAIL(inode, raw_inode);
> -	error = xattr_check_inode(inode, header, end);
> -	if (error)
> -		goto cleanup;
>  	entry = IFIRST(header);
>  	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
>  	if (error)
> @@ -783,7 +777,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	struct ext4_xattr_ibody_header *header;
>  	struct ext4_inode *raw_inode;
>  	struct ext4_iloc iloc;
> -	void *end;
>  	int error;
>  
>  	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> @@ -793,14 +786,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  		return error;
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
> -	end = ITAIL(inode, raw_inode);
> -	error = xattr_check_inode(inode, header, end);
> -	if (error)
> -		goto cleanup;
>  	error = ext4_xattr_list_entries(dentry, IFIRST(header),
>  					buffer, buffer_size);
>  
> -cleanup:
>  	brelse(iloc.bh);
>  	return error;
>  }
> @@ -868,7 +856,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  	struct ext4_xattr_ibody_header *header;
>  	struct ext4_xattr_entry *entry;
>  	qsize_t ea_inode_refs = 0;
> -	void *end;
>  	int ret;
>  
>  	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
> @@ -879,10 +866,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  			goto out;
>  		raw_inode = ext4_raw_inode(&iloc);
>  		header = IHDR(inode, raw_inode);
> -		end = ITAIL(inode, raw_inode);
> -		ret = xattr_check_inode(inode, header, end);
> -		if (ret)
> -			goto out;
>  
>  		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
>  		     entry = EXT4_XATTR_NEXT(entry))
> @@ -2237,9 +2220,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	is->s.here = is->s.first;
>  	is->s.end = ITAIL(inode, raw_inode);
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> -		error = xattr_check_inode(inode, header, is->s.end);
> -		if (error)
> -			return error;
>  		/* Find the named attribute. */
>  		error = xattr_find_entry(inode, &is->s.here, is->s.end,
>  					 i->name_index, i->name, 0);
> @@ -2790,10 +2770,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  	min_offs = end - base;
>  	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
>  
> -	error = xattr_check_inode(inode, header, end);
> -	if (error)
> -		goto cleanup;
> -
>  	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
>  	if (ifree >= isize_diff)
>  		goto shift;
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 5197f17ffd9a..1fedf44d4fb6 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -209,6 +209,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
>  extern struct mb_cache *ext4_xattr_create_cache(void);
>  extern void ext4_xattr_destroy_cache(struct mb_cache *);
>  
> +extern int
> +__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
> +		    void *end, const char *function, unsigned int line);
> +
> +#define xattr_check_inode(inode, header, end) \
> +	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
> +
>  #ifdef CONFIG_EXT4_FS_SECURITY
>  extern int ext4_init_security(handle_t *handle, struct inode *inode,
>  			      struct inode *dir, const struct qstr *qstr);
> -- 
> 2.34.1
> 

