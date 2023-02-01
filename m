Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A554686D3F
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 18:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBARnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 12:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjBARmz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 12:42:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB5790A7;
        Wed,  1 Feb 2023 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675273372; x=1706809372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=js3L+AzDGU0xPg5HFGb2hXzAfK0OXeg3c3aYSFlgN3E=;
  b=NTkwdMJHif89ibYIBRQ6sjWt7anHflycUnTgavZkldpH/EAWKtKzcZ0g
   MRhoW0ihtFCBQogLozytlQJxmkDKI+ckMPBU3x0gjhKLoOJZRbtwh2SsJ
   mm9qg7oLNE8/6tF5cmqFVIwjAhIXTds6RFZHaBlgvuZjDEjnIa2HjGRB5
   LlJfYvskviwele9PBZDM2KnADkyyvaNOfi/e3stwXSYRqbI0oFtJTFt1+
   n2/2rWixM+ghWeHqlOM8zpnsxsAAX2wP/kfagg3eJ741nV0p4XMJjOk8/
   8EzrBaaXif0QM0RCOTzQLEv2yJ+NRyD1TxKWHSsTTrx49P3cSVkGmqmae
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="316215187"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="316215187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="788967914"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="788967914"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2023 09:42:40 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNH83-0005e0-0b;
        Wed, 01 Feb 2023 17:42:39 +0000
Date:   Thu, 2 Feb 2023 01:42:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org
Subject: Re: [PATCH v9 05/25] dept: Tie to Lockdep and IRQ tracing
Message-ID: <202302020140.zbWuL7aK-lkp@intel.com>
References: <1675154394-25598-6-git-send-email-max.byungchul.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675154394-25598-6-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core drm-misc/drm-misc-next linus/master v6.2-rc6 next-20230201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230131-164632
patch link:    https://lore.kernel.org/r/1675154394-25598-6-git-send-email-max.byungchul.park%40gmail.com
patch subject: [PATCH v9 05/25] dept: Tie to Lockdep and IRQ tracing
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230202/202302020140.zbWuL7aK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ee619b0e7faff81e8b794e2adcdf9102d5bc83e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230131-164632
        git checkout ee619b0e7faff81e8b794e2adcdf9102d5bc83e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x164: call to context_tracking_guest_exit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x85: call to context_tracking_guest_exit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0xb1e: call to pentium_machine_check.constprop.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: lockdep_hardirqs_on+0x12: call to dept_hardirqs_on_ip() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: lockdep_hardirqs_off+0x9: call to dept_hardirqs_off_ip() leaves .noinstr.text section
   vmlinux.o: warning: objtool: lock_is_held_type+0x78: call to dept_hardirqs_off() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x14: call to dept_off() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x5a: call to dept_on() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_idle_exit+0x40: call to dept_hardirqs_off() leaves .noinstr.text section
   vmlinux.o: warning: objtool: check_stackleak_irqoff+0x2b: call to end_of_stack.isra.0() leaves .noinstr.text section


objdump-func vmlinux.o lockdep_hardirqs_on:
0000 000000000000b980 <lockdep_hardirqs_on>:
0000     b980:	f3 0f 1e fa          	endbr64
0004     b984:	55                   	push   %rbp
0005     b985:	53                   	push   %rbx
0006     b986:	48 89 fb             	mov    %rdi,%rbx
0009     b989:	65 48 8b 2c 25 00 00 00 00 	mov    %gs:0x0,%rbp	b98e: R_X86_64_32S	pcpu_hot
0012     b992:	e8 00 00 00 00       	call   b997 <lockdep_hardirqs_on+0x17>	b993: R_X86_64_PLT32	dept_hardirqs_on_ip-0x4
0017     b997:	8b 3d 00 00 00 00    	mov    0x0(%rip),%edi        # b99d <lockdep_hardirqs_on+0x1d>	b999: R_X86_64_PC32	debug_locks-0x4
001d     b99d:	85 ff                	test   %edi,%edi
001f     b99f:	0f 84 cd 00 00 00    	je     ba72 <lockdep_hardirqs_on+0xf2>
0025     b9a5:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # b9ac <lockdep_hardirqs_on+0x2c>	b9a8: R_X86_64_PC32	pcpu_hot+0x4
002c     b9ac:	a9 00 00 f0 00       	test   $0xf00000,%eax
0031     b9b1:	75 63                	jne    ba16 <lockdep_hardirqs_on+0x96>
0033     b9b3:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # b9ba <lockdep_hardirqs_on+0x3a>	b9b6: R_X86_64_PC32	lockdep_recursion-0x4
003a     b9ba:	85 c0                	test   %eax,%eax
003c     b9bc:	0f 85 b0 00 00 00    	jne    ba72 <lockdep_hardirqs_on+0xf2>
0042     b9c2:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # b9c9 <lockdep_hardirqs_on+0x49>	b9c5: R_X86_64_PC32	hardirqs_enabled-0x4
0049     b9c9:	85 c0                	test   %eax,%eax
004b     b9cb:	0f 85 b2 00 00 00    	jne    ba83 <lockdep_hardirqs_on+0x103>
0051     b9d1:	8b 35 00 00 00 00    	mov    0x0(%rip),%esi        # b9d7 <lockdep_hardirqs_on+0x57>	b9d3: R_X86_64_PC32	oops_in_progress-0x4
0057     b9d7:	85 f6                	test   %esi,%esi
0059     b9d9:	75 3b                	jne    ba16 <lockdep_hardirqs_on+0x96>
005b     b9db:	48 83 3d 00 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # b9e3 <lockdep_hardirqs_on+0x63>	b9de: R_X86_64_PC32	pv_ops+0xeb
0063     b9e3:	0f 84 ed 00 00 00    	je     bad6 <lockdep_hardirqs_on+0x156>
0069     b9e9:	ff 15 00 00 00 00    	call   *0x0(%rip)        # b9ef <lockdep_hardirqs_on+0x6f>	b9eb: R_X86_64_PC32	pv_ops+0xec
006f     b9ef:	f6 c4 02             	test   $0x2,%ah
0072     b9f2:	0f 85 c1 00 00 00    	jne    bab9 <lockdep_hardirqs_on+0x139>
0078     b9f8:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # b9fe <lockdep_hardirqs_on+0x7e>	b9fa: R_X86_64_PC32	oops_in_progress-0x4
007e     b9fe:	85 d2                	test   %edx,%edx
0080     ba00:	75 14                	jne    ba16 <lockdep_hardirqs_on+0x96>
0082     ba02:	48 8b 85 c8 0f 00 00 	mov    0xfc8(%rbp),%rax
0089     ba09:	48 39 85 f8 25 00 00 	cmp    %rax,0x25f8(%rbp)
0090     ba10:	0f 85 89 00 00 00    	jne    ba9f <lockdep_hardirqs_on+0x11f>
0096     ba16:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	ba19: R_X86_64_32S	.rodata.str1.1+0x16d93
009d     ba1d:	e8 00 00 00 00       	call   ba22 <lockdep_hardirqs_on+0xa2>	ba1e: R_X86_64_PLT32	__this_cpu_preempt_check-0x4
00a2     ba22:	8b 85 b0 10 00 00    	mov    0x10b0(%rbp),%eax
00a8     ba28:	48 89 9d b8 10 00 00 	mov    %rbx,0x10b8(%rbp)
00af     ba2f:	65 c7 05 00 00 00 00 01 00 00 00 	movl   $0x1,%gs:0x0(%rip)        # ba3a <lockdep_hardirqs_on+0xba>	ba32: R_X86_64_PC32	hardirqs_enabled-0x8
00ba     ba3a:	83 c0 01             	add    $0x1,%eax
00bd     ba3d:	48 83 3d 00 00 00 00 00 	cmpq   $0x0,0x0(%rip)        # ba45 <lockdep_hardirqs_on+0xc5>	ba40: R_X86_64_PC32	pv_ops+0xeb
00c5     ba45:	89 85 b0 10 00 00    	mov    %eax,0x10b0(%rbp)
00cb     ba4b:	89 85 c8 10 00 00    	mov    %eax,0x10c8(%rbp)
00d1     ba51:	74 49                	je     ba9c <lockdep_hardirqs_on+0x11c>
00d3     ba53:	ff 15 00 00 00 00    	call   *0x0(%rip)        # ba59 <lockdep_hardirqs_on+0xd9>	ba55: R_X86_64_PC32	pv_ops+0xec
00d9     ba59:	f6 c4 02             	test   $0x2,%ah
00dc     ba5c:	75 72                	jne    bad0 <lockdep_hardirqs_on+0x150>
00de     ba5e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	ba61: R_X86_64_32S	.rodata.str1.1+0x16d99
00e5     ba65:	e8 00 00 00 00       	call   ba6a <lockdep_hardirqs_on+0xea>	ba66: R_X86_64_PLT32	__this_cpu_preempt_check-0x4
00ea     ba6a:	65 48 ff 05 00 00 00 00 	incq   %gs:0x0(%rip)        # ba72 <lockdep_hardirqs_on+0xf2>	ba6e: R_X86_64_PC32	lockdep_stats+0xc
00f2     ba72:	5b                   	pop    %rbx
00f3     ba73:	5d                   	pop    %rbp
00f4     ba74:	31 c0                	xor    %eax,%eax
00f6     ba76:	31 d2                	xor    %edx,%edx
00f8     ba78:	31 c9                	xor    %ecx,%ecx
00fa     ba7a:	31 f6                	xor    %esi,%esi
00fc     ba7c:	31 ff                	xor    %edi,%edi
00fe     ba7e:	e9 00 00 00 00       	jmp    ba83 <lockdep_hardirqs_on+0x103>	ba7f: R_X86_64_PLT32	__x86_return_thunk-0x4
0103     ba83:	65 48 ff 05 00 00 00 00 	incq   %gs:0x0(%rip)        # ba8b <lockdep_hardirqs_on+0x10b>	ba87: R_X86_64_PC32	lockdep_stats+0x1c
010b     ba8b:	5b                   	pop    %rbx
010c     ba8c:	5d                   	pop    %rbp
010d     ba8d:	31 c0                	xor    %eax,%eax
010f     ba8f:	31 d2                	xor    %edx,%edx
0111     ba91:	31 c9                	xor    %ecx,%ecx
0113     ba93:	31 f6                	xor    %esi,%esi
0115     ba95:	31 ff                	xor    %edi,%edi
0117     ba97:	e9 00 00 00 00       	jmp    ba9c <lockdep_hardirqs_on+0x11c>	ba98: R_X86_64_PLT32	__x86_return_thunk-0x4
011c     ba9c:	90                   	nop
011d     ba9d:	0f 0b                	ud2
011f     ba9f:	90                   	nop
0120     baa0:	e8 00 00 00 00       	call   baa5 <lockdep_hardirqs_on+0x125>	baa1: R_X86_64_PLT32	debug_locks_off-0x4
0125     baa5:	85 c0                	test   %eax,%eax
0127     baa7:	74 0a                	je     bab3 <lockdep_hardirqs_on+0x133>
0129     baa9:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # baaf <lockdep_hardirqs_on+0x12f>	baab: R_X86_64_PC32	debug_locks_silent-0x4
012f     baaf:	85 c0                	test   %eax,%eax
0131     bab1:	74 41                	je     baf4 <lockdep_hardirqs_on+0x174>
0133     bab3:	90                   	nop
0134     bab4:	e9 5d ff ff ff       	jmp    ba16 <lockdep_hardirqs_on+0x96>
0139     bab9:	90                   	nop
013a     baba:	e8 00 00 00 00       	call   babf <lockdep_hardirqs_on+0x13f>	babb: R_X86_64_PLT32	debug_locks_off-0x4
013f     babf:	85 c0                	test   %eax,%eax
0141     bac1:	74 0a                	je     bacd <lockdep_hardirqs_on+0x14d>
0143     bac3:	8b 0d 00 00 00 00    	mov    0x0(%rip),%ecx        # bac9 <lockdep_hardirqs_on+0x149>	bac5: R_X86_64_PC32	debug_locks_silent-0x4
0149     bac9:	85 c9                	test   %ecx,%ecx
014b     bacb:	74 0c                	je     bad9 <lockdep_hardirqs_on+0x159>
014d     bacd:	90                   	nop
014e     bace:	eb a2                	jmp    ba72 <lockdep_hardirqs_on+0xf2>
0150     bad0:	90                   	nop
0151     bad1:	0f 0b                	ud2
0153     bad3:	90                   	nop
0154     bad4:	eb 88                	jmp    ba5e <lockdep_hardirqs_on+0xde>
0156     bad6:	90                   	nop
0157     bad7:	0f 0b                	ud2
0159     bad9:	90                   	nop
015a     bada:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	badd: R_X86_64_32S	.rodata.str1.1+0x16d82
0161     bae1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	bae4: R_X86_64_32S	.rodata.str1.1+0x16d41
0168     bae8:	e8 00 00 00 00       	call   baed <lockdep_hardirqs_on+0x16d>	bae9: R_X86_64_PLT32	__warn_printk-0x4
016d     baed:	90                   	nop
016e     baee:	0f 0b                	ud2
0170     baf0:	90                   	nop
0171     baf1:	90                   	nop
0172     baf2:	eb d9                	jmp    bacd <lockdep_hardirqs_on+0x14d>
0174     baf4:	90                   	nop
0175     baf5:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	baf8: R_X86_64_32S	.rodata.str1.8+0x2f280
017c     bafc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	baff: R_X86_64_32S	.rodata.str1.1+0x16d41
0183     bb03:	e8 00 00 00 00       	call   bb08 <lockdep_hardirqs_on+0x188>	bb04: R_X86_64_PLT32	__warn_printk-0x4
0188     bb08:	90                   	nop
0189     bb09:	0f 0b                	ud2
018b     bb0b:	90                   	nop
018c     bb0c:	90                   	nop
018d     bb0d:	eb a4                	jmp    bab3 <lockdep_hardirqs_on+0x133>
018f     bb0f:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
019a     bb1a:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
01a5     bb25:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
01b0     bb30:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
01bb     bb3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
