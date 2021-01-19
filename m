Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5685B2FAF2C
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jan 2021 04:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbhASDlg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jan 2021 22:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbhASDld (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jan 2021 22:41:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC27C061573
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jan 2021 19:40:52 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v19so12155086pgj.12
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jan 2021 19:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PGfjNXq6kQQR7eS17AeEF6df0fZnPpvtkWbRWExs/JM=;
        b=PtnBgYE0iSjqyMdDfhpmWv8Lg0EG0N1/xh/CU7+k0yHp357EiZ2XzRL/VMYy0mIO9t
         YLQqLYR8PB2Uf8p5s6kTzFDl9fpHEwe9rRcqiuiVNXjzGHc3qUpX1JDCXi4YNHlGdT4Y
         BHUb+HFqH5VFYQuE0ID6HlTpOKYpaGoM14VQjau/wKgcet34CxzGfA5ur0zWJ1cmVEN0
         nIi0sXmXLsSIs7SkFa2j2YEdcBLtzPdmQyyH1ooiwMgehezt1F4SlpqcLkszBMNv72l+
         D3cVUYVbvxL3t9stHAY8n61buGUD1pv2t3xR50JKC6PWAFy2XSXCznMZGQX9ecq8JJBa
         D2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PGfjNXq6kQQR7eS17AeEF6df0fZnPpvtkWbRWExs/JM=;
        b=V1Y0D0dZ5g1JHgmc2rGAm4jawUGI4hvr79INNNy1Bw1J0sOo0TPWrSOuQFGqmm5Gl7
         HB9TBz7zQeSkupaf5sVWf1Vvc2wMzfXt1qu+qUsqy+NsSXbajgdAUXsFdCfyEPk0gRiz
         JTJoWPEVT/IroFlMsQsk5m/8ROps5Vsa6kbwPp9SUmrVVMAUFOpaxn7AdkrafM/l2aGQ
         SdckaeN+S+yudNQZ+q+xryueWLdwqWGM+n2bDy3VacsSRq/bjOikYCSb84Le46jj+HWb
         sY2sIkqF/j20wtcRO7xH/JnOr8V2Y4MNZeCnFL8TCvIlHHzqQOWDzZvr8cOxjy5rPdgI
         rEHA==
X-Gm-Message-State: AOAM530Ax8fEfrTR+zM9FzaAD8v9VVlAnRldsOQahjttFLP4mRM6/kA6
        6HTlr+ygTqNuSDECiyWwzLmgq44vnVEgyRFB
X-Google-Smtp-Source: ABdhPJwRUzFSx0nZUHVuH/f0gVBY6ebX5wd0Z8uBWYU4UYBSN1V5D136EL6iEO8ygmnXUnfJHPoW2w==
X-Received: by 2002:a05:6a00:2d5:b029:1b9:67bd:b60f with SMTP id b21-20020a056a0002d5b02901b967bdb60fmr1900449pft.10.1611027651959;
        Mon, 18 Jan 2021 19:40:51 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v19sm846462pjg.50.2021.01.18.19.40.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 19:40:51 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <90D76828-C2EE-459A-A190-8E4FB51CE118@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_BAFC053F-6A71-4A0C-B59D-A34062BEEE2F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: code questions about ext4_inode_datasync_dirty()
Date:   Mon, 18 Jan 2021 20:40:47 -0700
In-Reply-To: <20210113171943.GB26686@quack2.suse.cz>
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph qi <joseph.qi@linux.alibaba.com>
To:     Jan Kara <jack@suse.cz>
References: <c95ac3d6-5e9c-b706-28f7-3bbe4b75964b@linux.alibaba.com>
 <20210113171943.GB26686@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_BAFC053F-6A71-4A0C-B59D-A34062BEEE2F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 13, 2021, at 10:19 AM, Jan Kara <jack@suse.cz> wrote:
> 
> Hi!
> 
> On Tue 12-01-21 19:45:06, Xiaoguang Wang wrote:
>> I use io_uring to evaluate ext4 randread performance(direct io), observed
>> obvious overhead in jbd2_transaction_committed():

I was going to ask about this - is the filesystem mounted with noatime or
relatime or lazytime?  Otherwise, it may be a lot of atime updates that are
causing all of this journal traffic in what _should_ be a read-only workload?

Cheers, Andreas






--Apple-Mail=_BAFC053F-6A71-4A0C-B59D-A34062BEEE2F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAGVL8ACgkQcqXauRfM
H+DM5w/+IRoHDk0YxSLX03YIMfN6tK7QvRzwH7xoWnXSUGQuIryR02V698h0Sh1+
1zxPfqReM1CqTIKq0hqOgb+M4mG5l4es8XxYYWjQfwS1zjCdlCvnp/cQsLXsukn7
nWMescS587Xx/Ug1LuOabZtD7Xg/oNvyYptbGc7QOOn5gxvBbmzSzPxIzD5kFXEE
n3wVic/KCAX04dK/crOlX11R1rImOSVq2VxcgyagW46X9ulrpT63GDdjYRFN9D/E
p/rUkejdk+tqlnqh583qaw6G3a4NB/VBvchUo42WcpAuW3r0zXS0egzNzxuOs84/
lV1OxZvlBPZipdBlNUVo/w3SRqALpjp/cyRVjwnqgR/6SH0gYR7wbKDemCkGm19N
q5hLk0+Fj9dzGe16HHNrVcgbpOQw+Gqs84ucqC/DqWEnenN0PCJUuumFqAT0/w/Z
it3JofKGRY+11gpJjjGyRIXl+v9YgV38jNRkT5kwW0YHsqAjI5szZgDUWGrkWTmh
qh/94UQFBhYKzuLpSLnIp7m21xPLiIlrN1Py8pGXFmmhDW8TsosQUHDUHnoo14IW
E+vITeHFRGYEvdvBtXEeIToCJMESY3ulTQTyyr5EnbNJ2iFP9SubIzPIb2zd0U+B
epFk3EpQ50VeHQJz49I5g9/gV0o6EQCCMTjJO1Tt6kmqekSnphs=
=8LuK
-----END PGP SIGNATURE-----

--Apple-Mail=_BAFC053F-6A71-4A0C-B59D-A34062BEEE2F--
