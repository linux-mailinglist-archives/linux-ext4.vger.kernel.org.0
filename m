Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8560C395145
	for <lists+linux-ext4@lfdr.de>; Sun, 30 May 2021 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhE3OWi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3OWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 May 2021 10:22:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00269C061574
        for <linux-ext4@vger.kernel.org>; Sun, 30 May 2021 07:20:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b9so12512680ejc.13
        for <linux-ext4@vger.kernel.org>; Sun, 30 May 2021 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DdHInFa66V3Wy3Vg9xusxyAkm3LkcQGinNchIVa5evA=;
        b=D+mxa9JP6OI3l8hOcLZiYolozQZZ0gHFvgVbZkjKKJ16+tnB0UrStROpyHC7Q0bjxn
         4SfQ+xT/fIEri9CUkGQziBGQtit3b1ZKung8Jjr38Avuex5jLGzAkLVGnurSX8LxqSm/
         pHwIqvv/oBJn8oPN01sxHxqlaPKWzaE+R5eYRjVhbsScqGwPHH+Ou1meBoW6KZ4wUYmC
         GffnjY3rcWy8fGZWtO1jc8R0fIqYwdH74Q8HlWdX97Na+zM84hxSEwD1cO0eS3eORLs9
         EUN0eXcw5SC7VfcsP9OJ1ixJWBZpWV6CT/HY4Z9TdGaxvX1+RJCkvjnjp92Ar3DaaN+w
         hNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DdHInFa66V3Wy3Vg9xusxyAkm3LkcQGinNchIVa5evA=;
        b=AKZlaq9GHWUOAr1ATfSLP9i/pHODg7yDEsHEa3TfSne2yUB1keBRg8u2cK2V0kBtV3
         GdAqGYN+kWRteCbfX3SewSx/E7+2RqRdQHd674BRBCPOL7PO6mYvUD8PkJhE1rrcaXYW
         cHh/pwAzxQUUfIoP5M/QZbfeOudU08wmatUNaTi1rjvAN4hdLoyjEk9ueNfFkq8kxeJV
         9AXfnB4ckOcWwJGxZvzjOgudHcdEHlIXh9rT+ybdt24eG7zTGfE2bmnrXO/Vowy0FtnC
         NckgRz/nvWRv1XYjQatDp8m4PEyQGvHO5WiQnVxMbnzptSfpOC9Vk6VeJ6gxZg++4Xog
         mBNw==
X-Gm-Message-State: AOAM5302NmBiwdRaUGuMuLhRLWALRVtkqe5xkVtXQuRx5WopkDMeYCaq
        Pkbsh9aJB6znJ+0fHSS5SFrz7WoBhYRLBXNgCv8=
X-Google-Smtp-Source: ABdhPJx4BQHrZ0Q2JysOg56BnwQ+TfYGra+f0HRqcA57PHeU5mVjh8pQGZX7uTswCNwZ/13NeTrJJYbxRcluyZjKuMY=
X-Received: by 2002:a17:906:c0c6:: with SMTP id bn6mr17666209ejb.436.1622384458490;
 Sun, 30 May 2021 07:20:58 -0700 (PDT)
MIME-Version: 1.0
From:   tianyu zhou <tyjoe.linux@gmail.com>
Date:   Sun, 30 May 2021 22:20:48 +0800
Message-ID: <CAM6ytZooJ9jJp4rZn4HRjh7RANrB981xVkyOTYWZPadQBa68nQ@mail.gmail.com>
Subject: Check for CAP_SYS_ADMIN before thaw/freeze block device
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, from commit "fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and
thaw filesystems" (SHA: f3f1a18330ac1b717cd7a32adff38d965f365aa2), I
learned that "The user in control of a super block should be allowed
to freeze and thaw it".

However, unlike ioctl_fsthaw and ioctl_fsfreeze which use ns_capable
to check CAP_SYS_ADMIN in super block's user ns, function thaw_bdev
and freeze_bdev in fs/block_dev.c also do the same thaw/freeze
operation to super block, with no check for CAP_SYS_ADMIN.

I searched these two functions' callers, and found there are check for
CAP_SYS_ADMIN before the callers call them, however, the check is
using capable which is inconsistent with the the commit I mentioned
earlier.

Here is an example:
-----------------------------
// fs/ext4/ioctl.c
static int ext4_shutdown(struct super_block *sb, unsigned long arg)
{
    ...
    if (!capable(CAP_SYS_ADMIN))
        return -EPERM;
    ...
    switch (flags) {
        case EXT4_GOING_FLAGS_DEFAULT:
            freeze_bdev(sb->s_bdev);
-----------------------------

So it is possible to change this kind of CAP_SYS_ADMIN check from
capable() to ns_capable() to keep consistency with the former commit?

Thanks!

Best regards,
Tianyu
