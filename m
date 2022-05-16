Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992965280E1
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiEPJa5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiEPJa4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 05:30:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DF2612C
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 02:30:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m23so17401048ljc.0
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=88YPtanQoCewrklAQjIZKZmT3p6n1PFuQ/LT13ahwDg=;
        b=mHyVl9f/YQTlAcAJOVq0azTfxsFX8FfKd92+Ih9VatVpWXxvYiqnKy82fQo96gKOwi
         Bm5Ld6RGQ5cWTQ0At5lnjgiAIUSZNoAwKfLjfsz0wa7nKLtqxQ7SxU/XLl4VaK7OXZ+2
         Zl3rHou0cn2EOAmp08S3NohXj+MjxmngclFHDQgTlZjRLWkz+RNJzu3C6yhg/BLQk+p5
         fxIQ7t0+ASEx1YTPH4BNsa1KkRAGzqD1y+8bTKAypV6oXt+kEdWDq4Ptou/qFTEOxRyF
         NGcqsHTAMnc/FDXeVa0kvz+GixXHetj6jtwaKjP3NJ2MTS9BL7sTr+4OaKGhLLYGt2Xo
         RQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=88YPtanQoCewrklAQjIZKZmT3p6n1PFuQ/LT13ahwDg=;
        b=T8PFf79gxrCxP57YCNZzCZIw6PF2nZLYNVIhTprrXeZRzA/+EWR+TzMmtjqo5/tp+A
         hksiWzDbcLGPjdQXz4GXDaITrGcMum6x5yoSxid31WxM1XGKrSvapGuWw7+HkRri9wUl
         7fOL3TegAhTGvs4AKDEvtqsVWd/JZvalHj/PRdi8y75YDutMYDx0ioLQeCh9yq9WGoO4
         unC9g/hNEZrgCCN01rXqniSilA9k7UdoFkpJYoyVUE2scR/aB/0VfbuTqkTp1hf8yjZa
         QlBxmKitMuD3uaqPdVHN1XtOo1go41HSMkEA1NziIjWUZQ+MtAThuasTPWtYttEvR/7J
         21gA==
X-Gm-Message-State: AOAM531bvsc8JkiOAzrPrl/0bgp7pDiZdfUugIezz28uFrQo5LBswm/s
        UryBQiTk2DpdjS/PUWXA7vxQ+3AoFLTkHx+hm7BY2kKigSfwiQ==
X-Google-Smtp-Source: ABdhPJzrnRTB5EIvIEKOr3KToJbIGgJn1S8lP+zgRzMIoyndCbw8SfgodSrY4r6BS9pG8L40URTTo1URgojb0Tpg1IM=
X-Received: by 2002:a2e:bf01:0:b0:247:dfe7:62dc with SMTP id
 c1-20020a2ebf01000000b00247dfe762dcmr10900672ljr.365.1652693451090; Mon, 16
 May 2022 02:30:51 -0700 (PDT)
MIME-Version: 1.0
From:   "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Date:   Mon, 16 May 2022 15:00:14 +0530
Message-ID: <CAKuJGC-uO-ywctcRH-i0UUfvzX3Yvep0kpSVi+FQXJjWgYMtdA@mail.gmail.com>
Subject: fast_commit option not recognized/supported by e2fsck?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,
Seems like I can't use the new fast_commit option.

Steps:
$ apt-get install gcc make bison -y && wget
https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot/e2fsprogs-1.46.4.tar.gz
tar -xvf e2fsprogs-1.46.4.tar.gz && cd e2fsprogs-1.46.4 && ./configure
&& make -j2 && sudo make install
$ sudo tune2fs -O fast_commit /dev/nvme0n1p2
# and verified flags with
$ sudo tune2fs -l /dev/nvme0n1p2 | grep fast_commit
Filesystem features:      has_journal ext_attr resize_inode dir_index
fast_commit filetype needs_recovery extent 64bit flex_bg sparse_super
large_file huge_file dir_nlink extra_isize metadata_csum
$ e2fsck -V
e2fsck 1.46.4 (18-Aug-2021)
Using EXT2FS Library version 1.46.4, 18-Aug-2021
$ uname -a
Linux db 5.13.0-1022-aws #24~20.04.1-Ubuntu SMP Thu Apr 7 22:14:11 UTC
2022 aarch64 aarch64 aarch64 GNU/Linux

Now I did a reboot and the system hangs. It shows the following error
message. Any thoughts on what's going wrong here? thanks!

```
Begin: Will now check root file system ... fsck from util-linux 2.34
[/usr/sbin/fsck.ext4 (1) -- /dev/nvme0n1p2] fsck.ext4 -a -C0 /dev/nvme0n1p2
/dev/nvme0n1p2 has unsupported feature(s): fast_commit
e2fsck: Get a newer version of e2fsck!

/dev/nvme0n1p2: ********** WARNING: Filesystem still has errors **********

fsck exited with status code 12
done.
Failure: File system check of the root filesystem failed
The root filesystem on /dev/nvme0n1p2 requires a manual fsck
```


----
Cheers,
Lakshmipathi.G
http://www.giis.co.in https://www.webminal.org
