Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97038221E3
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2019 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfERGok (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 May 2019 02:44:40 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:40251 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGok (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 May 2019 02:44:40 -0400
Received: by mail-it1-f170.google.com with SMTP id g71so15482907ita.5;
        Fri, 17 May 2019 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sm66+ylpmcUA5BNLiB9/0HEx+0otM0IFKrhWzKWuuyo=;
        b=DtnfHMV4rPfs4QiVZFgW/bOpTUOaTdOuZgSQupG534bwUjgQQeDDX+/qkIhHGwjtBQ
         +6RD4DXECMZKDV0ZSw1y8jM/mp5T9/dRANLNc+UU/pJPAYDaYtOOGyIJ9K42QYOiptdM
         yQfDnJjHKEsF7DqkpXh17y9wMth1tjB8JQZYNEGpZ+xE4qfcFj2Fo3InLVU/SuTOUPB8
         VBbgSRqxp36rKV812RScyfARSQzc+5WHZhxDafFp6x7T6sewHKHfkFhVKGap/2ezbNVn
         pAG+sSF25uyaqzZZulQuVef0ao0BlrVoILRdi+WvJg0XFOdmvEc1EjB4YfH56l/SMbZT
         IvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sm66+ylpmcUA5BNLiB9/0HEx+0otM0IFKrhWzKWuuyo=;
        b=LcbVQLsYOUT5WLhNOcyYY+8jUNeVXyaf8+3s7/7SGq4t8YukgPznmxk6ITjz1/S0du
         oBn2Mg+Nj8+gBNy7J24lkcLCU06q19kA48j3+1xIjkp5ojQpp0DPp8Y4YdKYkAxQskVQ
         /L38jZ+YlQ0aVVM5p5IuDoepT4mdnNX2UUNkChe4nMuXDg3Vc54qpPKQGPZsJHT82hai
         cCvCNc8sEEMfAKcobQTTECILlId72VmnRq6N6NxeUfoui54PtRYeJXPVEaOZUSOYEMOS
         1A/zRknTuOrFLdkTT/mnIvo9GxnQLliR4mLtMwd8SwsmBISBCYC2lNU2Mx8KFft7Lxfe
         fOfg==
X-Gm-Message-State: APjAAAXV/wznEFs6XYLXdqTQxb5IcENBGFclb1I9fU/BwpMaXKUnZj8b
        xA+sS4oJrJxVwwfkTW2vjIFUp2Ol50LfSj73kZmX0ncOllCovA==
X-Google-Smtp-Source: APXvYqzS+G/zaLwEZaQJCFGlI3m9T1Aj9pWGRglyyWqqy1aO1BJ9ufKmBCjJnBa/JEi2VnOOTx/L2V80eQ5OdXC/VZY=
X-Received: by 2002:a24:f9c3:: with SMTP id l186mr5875379ith.44.1558161878939;
 Fri, 17 May 2019 23:44:38 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 18 May 2019 11:44:28 +0500
Message-ID: <CABXGCsNPMSQgBjnFarYaxuQEGpA1G=U4U9OHqT0E53pNL2BK8g@mail.gmail.com>
Subject: [bugreport] kernel 5.2 pblk bad header/extent: invalid extent entries
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi folks.
Yesterday I updated kernel to 5.2 (git commit 7e9890a3500d)
I always leave computer working at night.
Today at morning I am found that computer are hanged.
I was connect via ssh and look at kernel log.
There I had seen strange records which I never seen before:

[28616.429757] EXT4-fs error (device nvme0n1p2): ext4_find_extent:908:
inode #8: comm jbd2/nvme0n1p2-: pblk 23101439 bad header/extent:
invalid extent entries - magic f30a, entries 8, max 340(340), depth
0(0)
[28616.430602] jbd2_journal_bmap: journal block not found at offset
4383 on nvme0n1p2-8
[28616.430610] Aborting journal on device nvme0n1p2-8.
[28616.432474] EXT4-fs error (device nvme0n1p2):
ext4_journal_check_start:61: Detected aborted journal
[28616.432489] EXT4-fs error (device nvme0n1p2):
ext4_journal_check_start:61: Detected aborted journal
[28616.432551] EXT4-fs (nvme0n1p2): Remounting filesystem read-only
[28616.432690] EXT4-fs (nvme0n1p2): ext4_writepages: jbd2_start:
9223372036854775791 pages, ino 3285789; err -30
[28616.432692] EXT4-fs error (device nvme0n1p2):
ext4_journal_check_start:61: Detected aborted journal

After reboot computer and running fsck system looks like working.
But I am afraid that it could happens again and I may lost all my data.

How safe this error and what does it mean?
It a bug of kernel 5.2 or not?

--
Best Regards,
Mike Gavrilov.
