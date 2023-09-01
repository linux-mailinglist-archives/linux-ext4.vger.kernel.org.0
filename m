Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240C78FED1
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349927AbjIAOSX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 10:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjIAOSW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 10:18:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0C10EC;
        Fri,  1 Sep 2023 07:18:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0bae4da38so128835ad.0;
        Fri, 01 Sep 2023 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693577898; x=1694182698; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+k9jCdWH9ria3G+t4iPStww6Lw/Q+Bd+gGPJInKFFM=;
        b=kN/mjRmO0Wjqt/fxLYMJD9mOuwCB9Uq0648ttgKR+pNRzjrtoipFfSHX1EGZfhORtE
         zZRTmKJpgXGfx75LpeQwIgoqGj2fgWlE8XVZdJemfgzjEhpz4/scCJOX8fIZZRTGv/oe
         IMwjPpmEc0at5LeUF+J9TzlNspDgHvH2ND+fr1jWDI/PEF6P4GIIZV0/18dhqrSebJsJ
         obeOW8QxwECp3I5IyIL1tM2WeN/XWAxnxmk5FLVsARNR92PEpmXbfxYCam00StVtt3rk
         +yb08TfZbJJ5WlRmwMmOVJVAfzbK9uT5ST9D9aj0iBULrU11yyMO8eMo1OsrvRknI8qC
         sEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577898; x=1694182698;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+k9jCdWH9ria3G+t4iPStww6Lw/Q+Bd+gGPJInKFFM=;
        b=UT9o1VbI5t7OQAgZ4ndOEFn9XuAd9lDYMeQI0zDHk31ULim74AHFdFFOolUq0PatAT
         EW767Xf/k3dp27ViSfbaT4bwWoem8n06yZp19yknCdyRl4BNXwZM3gQHA44QnE00lRol
         DtUv8XaDeRoIxY0NwF6gOajF+1raXtvNTi0jSDY/ctcyqA+FifZxHFn6t+RFfrIo0i1j
         fstHad4DIXPW07Cx1gRmCz1Gl9MiSgoYwfRU/4ta1PtPM7MKew7B0WAVMExzmLWfcnb2
         1jagB1ENUTcwdDxnyC6VBPCJpmWVa3yUL+GmlbN84pjsE57fCRZif1EP656iadRtNHCE
         E+7w==
X-Gm-Message-State: AOJu0YxvVEHzvXvpUalXCFB2oYFN7KVCOOTFtrmwBCEufi6zJMS2f3a0
        tofO/DrszZt7Yt1pdE23CnB9mw+H7aA=
X-Google-Smtp-Source: AGHT+IHx3F6UgKqGMpavylGAhJW9ecWS0bBoI58iu/P/TRFUmQI08o59pqi9G2WjsuDdefMvKGwAIA==
X-Received: by 2002:a17:903:244d:b0:1b2:676d:1143 with SMTP id l13-20020a170903244d00b001b2676d1143mr3721428pls.15.1693577898096;
        Fri, 01 Sep 2023 07:18:18 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902ac8e00b001c09d6feeb6sm3059168plr.165.2023.09.01.07.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:18:17 -0700 (PDT)
Date:   Fri, 01 Sep 2023 19:48:13 +0530
Message-Id: <87zg266kpm.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/11] ext4: add some kunit stub for mballoc kunit test
In-Reply-To: <20230826155028.4019470-10-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Multiblocks allocation will read and write block bitmap and group
> descriptor which reside on disk. Add kunit stub to function
> ext4_get_group_desc, ext4_read_block_bitmap_nowait, ext4_wait_block_bitmap
> and ext4_mb_mark_context to avoid real IO to disk.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/balloc.c  | 10 ++++++++++
>  fs/ext4/mballoc.c |  4 ++++
>  2 files changed, 14 insertions(+)

The patch looks good to me. Nice work in identifying functions which are
does I/O in mballoc context.

Looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
