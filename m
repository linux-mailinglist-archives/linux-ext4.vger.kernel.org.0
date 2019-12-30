Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024DA12D36E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2019 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfL3Shc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 13:37:32 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33951 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3Shc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 13:37:32 -0500
Received: by mail-pj1-f65.google.com with SMTP id s94so160669pjc.1
        for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2019 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7CYwpEaJs30fHn4kEU8jrIE4LC2mqdam+E00d9CT5Nc=;
        b=yKaxc9vVGHqh+5o0knX6gaRIJebDgOQhXWMoJ9iSb8msFoXtwQAzPR1jMKpRmrnsEj
         sZxriGm57BtjDGdiVZ4IM5Rf+0TfRyPFmXylOur3T0E8mQMKR7PvJRSs78PCvOmOmvn/
         ZszH9JQwR7/YqDEh4yBTwHKnhMWdrr/Po9aNxafsCd00elxVebE2z50rd5jiAHGBeRwW
         YqH3PMpweboAxvOkG7Le6BgtLlvOtXvUr2jM3/uUoU5/PWX0UwUHc+jonJvSufOwwPlS
         JiXwamnyyKGZic55nrmzdcGehiaBi2xTNNnhlYUAWFWlfC8OeAeaboaUY4YgRtc+2b3H
         1+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7CYwpEaJs30fHn4kEU8jrIE4LC2mqdam+E00d9CT5Nc=;
        b=WUdomZAl/zSb5gbjuJ4bjoZ7N/eOB1iojZaMkf7DUAG0LPfH6UMtH+AaWvMQbHaOzV
         c+ln+E7gYZYjBuzIT6VmL58j+wtyzD4K8T4DCOMZ/KXI6ObKg2QTo6WTPXrTSR3hDTDP
         PMYRx1l6yCgWVMUUIZPEWUKkv6pDpLJiyvx5fVgPX1tUNhBcmQLw/R4/PPqoUNT9xysZ
         GEgk6PPryatBQ0dGYesa0pJMO+kda+zDNCn+sKNgBC34D9rTOq+e60xqVCMezR7SB0PC
         AckMvHxR3mWrOGMawg/u9TJkG4rveZlkcP0rF6Jx1U3NbpToNt+wTRANnO85M7YqOS27
         P7bQ==
X-Gm-Message-State: APjAAAVbvcgGIUu6XWv2eq7aFJsz3ijYcRo84DB9855n4VzDsO2lInyo
        Qij7SpUxmu/ByiN/FybG81jLJg==
X-Google-Smtp-Source: APXvYqx5MlLbT3fu76XUx5JMSBE1pzyKEKqciRu2yeEPu9vFt7xo3CHwFMM5VijBOd461fAEC3UiTQ==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr579472pjk.57.1577731051396;
        Mon, 30 Dec 2019 10:37:31 -0800 (PST)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id u10sm48851642pgg.41.2019.12.30.10.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 10:37:30 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <37689479-8118-4ED1-A98C-4A3E982B4575@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_081E87A3-528C-409B-A70D-BD282B608196";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsprogs: fix to use inode i_blocks correctly
Date:   Mon, 30 Dec 2019 11:37:40 -0700
In-Reply-To: <20191230151921.GA125106@mit.edu>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lixi@ddn.com, dongyangli@ddn.com, Wang Shilong <wshilong@ddn.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <1577705766-20736-1-git-send-email-wangshilong1991@gmail.com>
 <20191230151921.GA125106@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_081E87A3-528C-409B-A70D-BD282B608196
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 30, 2019, at 8:19 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> On Mon, Dec 30, 2019 at 08:36:06PM +0900, Wang Shilong wrote:
>> blocks_from_inode() did not return wrong inode blocks, and
>> ext2fs_inode_i_blocks() is not taking EXT4_HUGE_FILE_FL into account
>> at all, while the some callers deal it correctly, some not. This patch
>> try to unify to handle it in ext2fs_inode_i_blocks() to return.
>> blocks(based on 512 bytes)
> 
> I don't really want to change the functionality of
> ext2fs_inode_i_blocks().  First of all, it's in a shared library, so
> if there are any binaries which were expecting the old behavior, that
> could get surprising.  Secondly, its name is confusing and so we're
> better off creating a new function ext2fs_get_stat_i_blocks() which
> makes it clear that we function is using units of 512 byte sectors,
> instead of either the file system block size, or the raw i_blocks
> value from the inode.
> 
> Two other things about your patch.  First of all, the filefrag command
> in debugfs was intended to print the number of file system blocks, so
> it was correct as written.  Secondly, please note the blkcnt_t is a
> signed type (because the block iterator functions use negative values
> to indicate various kinds of metadata blocks), while blk64_t is an
> unsigned type.  So using blkcnt_t as a temporary value and returning
> it in a function which has a return type of blk64_t will (righly)
> trigger compiler warnings.
> 
> Here's the patch I've checked into the maint branch of e2fsprogs to
> address the issue you've identified.

No patch is attached?

Cheers, Andreas






--Apple-Mail=_081E87A3-528C-409B-A70D-BD282B608196
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4KQ/QACgkQcqXauRfM
H+AnMRAAtZ3smIihnpHLNfHFStxarJNhReapjBE60Hmg5XGoVvb25AXlGkMoeOST
8QBk4UvrU5Tl7ZZNRRdwbuZVuRwJ3jdZlm7s3kE//PIgk7+PWGaxXIWKy4LSFu+v
1I2fn2EGxE3knolTvk4NbyR1aweyWopfFxfuFBVJgNdWSxWCLT1BxxnSC4oJ6X3k
REzxeE6ET1FDb+MsB1D4e7g3XxgNnmp3J/UbB5jryS6eB9qLHQm4OgJ7TWXlDpCZ
WgGt1Wz0RhUTiaz0YMuu6aGlhlKW+2ytmbW27IC0xIpyQZpi8l89gd9yAGNeqvhn
MFYF+VO5Gdii5b+c6+IOckFQjR7wNihZr9cpyIiYmezjAHQWAt+jTfhWmqvr+or1
LGCBuTAu8m7omgrBVw42QnTSAZobXEJJXuyu7lFdQROecFniLtAOgqFaWlDc3GYb
2L5iAbXgPfhmNJ+Tl3rxt4JlqK2UQX8hGRqy5YAsrI1xEcgK59PfdCzCp3AelqQv
oh965GSBPmKqvSvtrYHgxlVdEcUcyW1Kt8Z4taBxUBDo1heV4r5MQ8a94qPm2u5B
Nl+xLz+m0L5KrTxqxjMQP1Mav/Qy3q+Zx61uGLIKQkgP44qMbWqnMIhNDMnBX+al
/av+Jxn2hTTac1M9GoOxnuUshzPaHxYCvs8vNiJp0eL/1Rvw5eA=
=Kx5e
-----END PGP SIGNATURE-----

--Apple-Mail=_081E87A3-528C-409B-A70D-BD282B608196--
