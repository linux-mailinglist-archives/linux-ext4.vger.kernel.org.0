Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB11EA9D2
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jun 2020 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgFASCh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jun 2020 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgFASCd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Jun 2020 14:02:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEEC08C5C0
        for <linux-ext4@vger.kernel.org>; Mon,  1 Jun 2020 11:02:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d6so175497pjs.3
        for <linux-ext4@vger.kernel.org>; Mon, 01 Jun 2020 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5r2FLJZvS4apnVJUvia1LdiyjeetiucFqacIaJB0qwE=;
        b=kByfvhbrsfoJV5dc4p5p3XJ8Nwzy6nVtd8NCzRHkCKXO86yXpCmBAa6zUR32iOZTYA
         Lx1QBQBhqM7gzoipZTu9ewhI9K7S6i4fNvSCyv6XxthBOnY022I79JvcSSTjY6gRiWa0
         aafmieCdblGsUi3aoOKdf5vYe3xEH6t6Iyu9FOwFb306QQTFrH01MZcfyhgC6SvVYkTt
         0jQCLQdbUpV8MJ2VUjzgQToekZH0cN+rtsnQPknohyNZUBT2AO6jG/5+i7ByBSOEDMYX
         p/8V5MugpKcz8d3lad0DAtwWUw5Lv1mlY3Vc+8bfTUy/ttA8hJt7Asi6g+HQ83fXDQMt
         J3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5r2FLJZvS4apnVJUvia1LdiyjeetiucFqacIaJB0qwE=;
        b=DKWsRu7oFOz61aMMLxQa82Pk9Xj2OS3scB7/qryuascsILDXPvdoBqu4MPt+vj0zhm
         RZSjYMeh7A0lZonoZQTF3RSnQqGjKnL/1cjC5TscuHudvcPmsSMyKl64Mcl0pojUI1yw
         nNidtYenuTkbGZPxHGXj7J9wqQ4SPStnFQPjnN6UouefzZTm9tR5bvM845LE2cWcxtPe
         AdCG7lMMhTuCpbLq4kRRpu2Vve/gDDLYGhTX9tJJdFTncDzP9SlVjjdREboHdB7Mzawn
         4FWiN/xJd54WDeasdhZWF4+QBZENiJynY9e0+kbZCimRTBth8b7AB3t5ncTbVNxN5qgH
         0erA==
X-Gm-Message-State: AOAM5307UUWdHazaBifqZXSCDJV22H8AD2feEWQlYCIJZOwgDlZZ+rJD
        8+xmdBj9wdp9Xt+8A4oq3FVWadKcOrI41qEvwJSj3Q==
X-Google-Smtp-Source: ABdhPJyxCUI48+3yicisvCBE1NGabupp/bBH5IdsT37UC0TS1i1eaK2L+YZogniHkGgVRJCUFHo02kEckZ9JnWKwuh0=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr21165072plz.179.1591034552563;
 Mon, 01 Jun 2020 11:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <202006011907.ocBGNEZT%lkp@intel.com>
In-Reply-To: <202006011907.ocBGNEZT%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 11:02:20 -0700
Message-ID: <CAKwvOdkff8dwqHGkrnyK++e+yWTTYZwefPJ4wqqXQCQhmePE5A@mail.gmail.com>
Subject: Re: [ext4:dev 41/50] fs/ext4/mballoc.c:1494:2: error: invalid input
 size for constraint 'qi'
To:     kbuild test robot <lkp@intel.com>
Cc:     "Ritesh, Harjani," <riteshh@linux.ibm.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

nevermind this failure. Clang doesn't support i386 yet (WIP).

On Mon, Jun 1, 2020 at 4:41 AM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> head:   38bd76b9696c5582dcef4ab1af437e0666021f65
> commit: 42f56b7a4a7db127a9d281da584152dc3d525d25 [41/50] ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling
> config: i386-randconfig-a014-20200601 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2388a096e7865c043e83ece4e26654bd3d1a20d5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install i386 cross compiling tool for clang build
>         # apt-get install binutils-i386-linux-gnu
>         git checkout 42f56b7a4a7db127a9d281da584152dc3d525d25
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> fs/ext4/mballoc.c:1494:2: error: invalid input size for constraint 'qi'
> this_cpu_inc(discard_pa_seq);
> ^
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:377:11: note: expanded from macro '__pcpu_size_call'
> case 1: stem##1(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:160:1: note: expanded from here
> this_cpu_add_1
> ^
> arch/x86/include/asm/percpu.h:432:34: note: expanded from macro 'this_cpu_add_1'
> #define this_cpu_add_1(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> >> fs/ext4/mballoc.c:1494:2: error: invalid input size for constraint 'qi'
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:378:11: note: expanded from macro '__pcpu_size_call'
> case 2: stem##2(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:185:1: note: expanded from here
> this_cpu_add_2
> ^
> arch/x86/include/asm/percpu.h:433:34: note: expanded from macro 'this_cpu_add_2'
> #define this_cpu_add_2(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> >> fs/ext4/mballoc.c:1494:2: error: invalid input size for constraint 'qi'
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:379:11: note: expanded from macro '__pcpu_size_call'
> case 4: stem##4(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:210:1: note: expanded from here
> this_cpu_add_4
> ^
> arch/x86/include/asm/percpu.h:434:34: note: expanded from macro 'this_cpu_add_4'
> #define this_cpu_add_4(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> fs/ext4/mballoc.c:1636:2: error: invalid input size for constraint 'qi'
> this_cpu_inc(discard_pa_seq);
> ^
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:377:11: note: expanded from macro '__pcpu_size_call'
> case 1: stem##1(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:12:1: note: expanded from here
> this_cpu_add_1
> ^
> arch/x86/include/asm/percpu.h:432:34: note: expanded from macro 'this_cpu_add_1'
> #define this_cpu_add_1(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> fs/ext4/mballoc.c:1636:2: error: invalid input size for constraint 'qi'
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:378:11: note: expanded from macro '__pcpu_size_call'
> case 2: stem##2(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:37:1: note: expanded from here
> this_cpu_add_2
> ^
> arch/x86/include/asm/percpu.h:433:34: note: expanded from macro 'this_cpu_add_2'
> #define this_cpu_add_2(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> fs/ext4/mballoc.c:1636:2: error: invalid input size for constraint 'qi'
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:379:11: note: expanded from macro '__pcpu_size_call'
> case 4: stem##4(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:62:1: note: expanded from here
> this_cpu_add_4
> ^
> arch/x86/include/asm/percpu.h:434:34: note: expanded from macro 'this_cpu_add_4'
> #define this_cpu_add_4(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> fs/ext4/mballoc.c:3996:2: error: invalid input size for constraint 'qi'
> this_cpu_inc(discard_pa_seq);
> ^
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
> #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
> ^
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> ^
> include/linux/percpu-defs.h:377:11: note: expanded from macro '__pcpu_size_call'
> case 1: stem##1(variable, __VA_ARGS__);break;                                      ^
> <scratch space>:150:1: note: expanded from here
> this_cpu_add_1
> ^
> arch/x86/include/asm/percpu.h:432:34: note: expanded from macro 'this_cpu_add_1'
> #define this_cpu_add_1(pcp, val)        percpu_add_op(volatile, (pcp), val)
> ^
> arch/x86/include/asm/percpu.h:147:16: note: expanded from macro 'percpu_add_op'
> : "qi" ((pao_T__)(val)));                                                          ^
> fs/ext4/mballoc.c:3996:2: error: invalid input size for constraint 'qi'
> include/linux/percpu-defs.h:520:28: note: expanded from macro 'this_cpu_inc'
>
> vim +/qi +1494 fs/ext4/mballoc.c
>
>   1473
>   1474  static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>   1475                             int first, int count)
>   1476  {
>   1477          int left_is_free = 0;
>   1478          int right_is_free = 0;
>   1479          int block;
>   1480          int last = first + count - 1;
>   1481          struct super_block *sb = e4b->bd_sb;
>   1482
>   1483          if (WARN_ON(count == 0))
>   1484                  return;
>   1485          BUG_ON(last >= (sb->s_blocksize << 3));
>   1486          assert_spin_locked(ext4_group_lock_ptr(sb, e4b->bd_group));
>   1487          /* Don't bother if the block group is corrupt. */
>   1488          if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
>   1489                  return;
>   1490
>   1491          mb_check_buddy(e4b);
>   1492          mb_free_blocks_double(inode, e4b, first, count);
>   1493
> > 1494          this_cpu_inc(discard_pa_seq);
>   1495          e4b->bd_info->bb_free += count;
>   1496          if (first < e4b->bd_info->bb_first_free)
>   1497                  e4b->bd_info->bb_first_free = first;
>   1498
>   1499          /* access memory sequentially: check left neighbour,
>   1500           * clear range and then check right neighbour
>   1501           */
>   1502          if (first != 0)
>   1503                  left_is_free = !mb_test_bit(first - 1, e4b->bd_bitmap);
>   1504          block = mb_test_and_clear_bits(e4b->bd_bitmap, first, count);
>   1505          if (last + 1 < EXT4_SB(sb)->s_mb_maxs[0])
>   1506                  right_is_free = !mb_test_bit(last + 1, e4b->bd_bitmap);
>   1507
>   1508          if (unlikely(block != -1)) {
>   1509                  struct ext4_sb_info *sbi = EXT4_SB(sb);
>   1510                  ext4_fsblk_t blocknr;
>   1511
>   1512                  blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>   1513                  blocknr += EXT4_C2B(sbi, block);
>   1514                  ext4_grp_locked_error(sb, e4b->bd_group,
>   1515                                        inode ? inode->i_ino : 0,
>   1516                                        blocknr,
>   1517                                        "freeing already freed block "
>   1518                                        "(bit %u); block bitmap corrupt.",
>   1519                                        block);
>   1520                  ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>   1521                                  EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>   1522                  mb_regenerate_buddy(e4b);
>   1523                  goto done;
>   1524          }
>   1525
>   1526          /* let's maintain fragments counter */
>   1527          if (left_is_free && right_is_free)
>   1528                  e4b->bd_info->bb_fragments--;
>   1529          else if (!left_is_free && !right_is_free)
>   1530                  e4b->bd_info->bb_fragments++;
>   1531
>   1532          /* buddy[0] == bd_bitmap is a special case, so handle
>   1533           * it right away and let mb_buddy_mark_free stay free of
>   1534           * zero order checks.
>   1535           * Check if neighbours are to be coaleasced,
>   1536           * adjust bitmap bb_counters and borders appropriately.
>   1537           */
>   1538          if (first & 1) {
>   1539                  first += !left_is_free;
>   1540                  e4b->bd_info->bb_counters[0] += left_is_free ? -1 : 1;
>   1541          }
>   1542          if (!(last & 1)) {
>   1543                  last -= !right_is_free;
>   1544                  e4b->bd_info->bb_counters[0] += right_is_free ? -1 : 1;
>   1545          }
>   1546
>   1547          if (first <= last)
>   1548                  mb_buddy_mark_free(e4b, first >> 1, last >> 1);
>   1549
>   1550  done:
>   1551          mb_set_largest_free_order(sb, e4b->bd_info);
>   1552          mb_check_buddy(e4b);
>   1553  }
>   1554
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202006011907.ocBGNEZT%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
