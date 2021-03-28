Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2A34BE94
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Mar 2021 21:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhC1Tha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Mar 2021 15:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1ThZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Mar 2021 15:37:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B7C061756;
        Sun, 28 Mar 2021 12:37:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p12so3417898pgj.10;
        Sun, 28 Mar 2021 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mK0olNKdZ0k68ZyfY7bV23cVqsncnwxYmBvUZ2gAlQ8=;
        b=GKKn+DFl0jlUfZSvkt9RVI0o/0bz8XoqrNiwWyhEWxMYTbBt45te2rUsG1nNMjIJIi
         HJcZzmTuPS1OMins2kRM6QAmV0KAucxhzFZDo11mZhqpwVDfpCKbRaPAFVOyHzGT3gPu
         wgrhcUaT9JKwgXdQ2gx/QoIS6nJFm+i6g0b0D2B3/xKzRzUZi5Ar5EqLPcZf3Q9IjWT7
         Vc1Nexzhpo4m6p0pgGSp3VEOy2SJH2tlk20V8zdq725QQLGa0mFwmsvUQkQ3L5FRnqdh
         SX4aa8AwSRPHlmzKFq4tgkuhxkabTDBRSiT6MFK/F9XX1uhI4xJoM5l76K0YENyjjiHo
         n8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mK0olNKdZ0k68ZyfY7bV23cVqsncnwxYmBvUZ2gAlQ8=;
        b=ciJdAiDG6QpkLtIaSXcMfaWBKVsn2kw64ync0xYptYjZlXH83VztmyLQqf+0BSJJK2
         Pk+9WyblRHhMJif7EzO2sjiFOSXTDb+GDUOZjv1r9ACCNUbZNBRcrz2rTjXV14hX+fCI
         gxLLPcSfa7MIUGQgwqXtrMScYVLkb/5lUK1/d+FW8QNHkkZqeSx2kxZSqe/TNRDllTe6
         /0A+hljuppbFmTE/IuYkK5DAJU1IaO4XnZy4al7cWswsbnptfbhl92MnKfC19f46EzpY
         MJo0N+3aV67mcvFbMQKkObNUYl0rtmuOdkEGn9tIkuG1mlYg4adZNLtyxH70sO64VSF3
         KLog==
X-Gm-Message-State: AOAM530VUqJiEWliW1p4Y2gqGE95lBsuREPh8IbMDD9LSnFH+yn7qo3+
        0LF9exrMVoCMkd84UUPZlCI=
X-Google-Smtp-Source: ABdhPJyKo+HV+cz87sWous6GneDyegZza013lDpxJRViA3zMqjdVxQeCjtBJHrswFsp50dmKWrMBVw==
X-Received: by 2002:a65:4308:: with SMTP id j8mr21597895pgq.349.1616960244309;
        Sun, 28 Mar 2021 12:37:24 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id a22sm15877108pgw.52.2021.03.28.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 12:37:21 -0700 (PDT)
Date:   Mon, 29 Mar 2021 01:07:18 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] EXT4: Trivial typo fixes
Message-ID: <20210328193718.coakxjy7vns5iu64@riteshh-domain>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/03/27 04:00PM, Bhaskar Chowdhury wrote:
> This patch series fixed few mundane typos in the below specific files.
>
> Bhaskar Chowdhury (8):
>   EXT4: migrate.c: Fixed few typos
>   EXT4: namei.c: Fixed a typo
>   EXT4: inline.c: A typo fixed
>   Fix a typo
>   EXT4: indirect.c: A trivial typo fix
>   EXT4: xattr.c: Mundane typo fix
>   EXT4: fast_commit.c: A mere typo fix
>   EXT4: mballoc.h: Single typo fix
>
>  fs/ext4/fast_commit.c | 2 +-
>  fs/ext4/indirect.c    | 2 +-
>  fs/ext4/inline.c      | 2 +-
>  fs/ext4/inode.c       | 2 +-
>  fs/ext4/mballoc.h     | 2 +-
>  fs/ext4/migrate.c     | 6 +++---
>  fs/ext4/namei.c       | 8 ++++----
>  fs/ext4/xattr.c       | 2 +-
>  8 files changed, 13 insertions(+), 13 deletions(-)

Thanks,
since these are trivial typo fixes, why not just 1 patch for fs/ext4/
IMO, that way it is easier for sender, reviewer and maintainer.

-ritesh
