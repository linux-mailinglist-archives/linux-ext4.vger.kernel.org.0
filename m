Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8D2EA67
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfE3ByX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 21:54:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42286 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3ByW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 21:54:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id 33so980348pgv.9
        for <linux-ext4@vger.kernel.org>; Wed, 29 May 2019 18:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=coZ9D1SnDIwHu0n3iEOb1d0iPLPYmmA7ia65m7KWi9c=;
        b=IxBCtveQRiiBbCJKMU+a2GrC1pm1F2Apek26s/bfwXK4Hfqp77JM33scT/s3RVoq2G
         AOegmZB3V4z/BjEAT48KKrlzkn5Yy/HVjmU3FiL4NsmcehNSgFoDp/nFpMnrCnREBMb9
         iGwCFc0zsqbUMnkZbzzaigdLi7Rvx7VLSp51UCMVXyWrOvTjbI11bdk/2IWh7J2Gg10U
         KdzByLo03Z9Dh12TO8itw3RKq/MBfZPvWIHImDoQFLzAJHgjfGGcMTh4dXIJw0VOwOCu
         lPQ4OgZZ49A2Ns2LclbxtXQsLqTMfSI3hsXu+2tvj4dto3J75VQcoEnQAakcWaVCNiHG
         HSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=coZ9D1SnDIwHu0n3iEOb1d0iPLPYmmA7ia65m7KWi9c=;
        b=rHBqn+SfysY+nwU6SH8UJDiYtnJXw/wIzSObsYA13jCYuG2QKuyvLyqNdbcl2F9GIq
         oQfIvErilNNahs+L1Epbjwk/UZAg1TEvp9BnYfF9RIxEMXSWsTlXdQch04rvShQakuoQ
         zKwLVg69GWTdkQy8Wsd4WX6oYz6FKhSs1aXWhQQGfMWzYEp77q3DEghGyNec1emadeTt
         FPpq/NApawla33RZ74oAhnPbLzkD0GhPEtc52Wc3bi1Uxji102hHpBdOueQ0WjvXbPRw
         uMR0SvWP0/9wAq/tdZ/bl8MuhuhjWsghSdHvURqyEu0avJXSMZQrJLMWNT6JBtjZ2dpO
         +n8g==
X-Gm-Message-State: APjAAAVaflh9V5zV+ZIju61vfA2Ln/973Q5mOtZUvRz4G4rX4UHmm8Ft
        hUqbmy+08d8sM0AjhFq8SumORA==
X-Google-Smtp-Source: APXvYqykMj6rPEYbIr5/FWi3ioYNmYf9Y/DiS2PFxylrnGmONF9HM0erQ8y0aTSGcTneUnMZFs9HIg==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr1267456pgm.40.1559181261352;
        Wed, 29 May 2019 18:54:21 -0700 (PDT)
Received: from [10.198.36.90] ([24.244.29.249])
        by smtp.gmail.com with ESMTPSA id g17sm965118pfk.55.2019.05.29.18.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 18:54:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: How to package e2scrub
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190529235948.GB3671@mit.edu>
Date:   Wed, 29 May 2019 19:54:19 -0600
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09F0F480-CE7F-4B66-87FC-7BD8558EC82F@dilger.ca>
References: <20190529120603.xuet53xgs6ahfvpl@work> <20190529235948.GB3671@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rather than naming the packages "e2scrub-*" it makes more sense to me to use=
 "e2fsprogs-scrub" so that it is clear this is a sub-package of e2fsprogs?  O=
r is the thought that the scrub functionality might move out of e2fsprogs an=
d xfsprogs at some point in the future.

Cheers, Andreas

PS: I'd agree with Darrick that "xfsprogs-scrub" is probably a better name.=20=


> On May 29, 2019, at 17:59, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
>> On Wed, May 29, 2019 at 02:06:03PM +0200, Lukas Czerner wrote:
>> Hi guys,
>>=20
>> I am about to release 1.45.2 for Fedora rawhide, but I was thinking
>> about how to package the e2scrub cron job/systemd service.
>>=20
>> I really do not like the idea of installing cron job and/or the service a=
s
>> a part of regular e2fsprogs package. This can potentially really surprise=

>> people in a bad way.
>>=20
>> Note that I've already heard some complaints from debian users about the
>> systemd service being installed on their system after the e2fsprogs
>> update.
>=20
> One of the reasons I deliberately decided to enable it for Debian
> Unstable was it was the best way to flush out the bugs.  :-)
>=20
> Yeah, Debian Unstable users are my guinea pigs. :-)   Doesn't it work
> that way with Fedora and RHEL?  :-)
>=20
> BTW, The complaints were mostly from e2scrub_all not working correctly
> if certain packages weren't installed, or if the LVM package was
> installed, but there were no LVM volumes present, etc.  The other
> complaint I got was when there was no free space for the snapshot.
> I'm kind of hopeful that I've gotten them all at this point, but we'll
> see....
>=20
>> What I am going to do is to split the systemd service into a separate
>> package and I'd like to come to some agreement about the name of the
>> package so that we can have the same name across distributions (at least
>> Fedora/Debian/Suse).
>=20
> Hmm.... what keeping the service as part of the e2fsprogs package, but
> then not enabling out of the box.  That is, require that user run:
>=20
> systemctl enable e2scrub_all.timer
>=20
> in order to actually get the feature?  (They can also disable it using
> "systemctl disable e2scrub_all.timer".)
>=20
> As far as the cron job is concerned, we could just leave the crontab
> entry commented out by default, and require that the user go in and
> edit the /etc/cron.d/e2scrub_all file if they want to enable it.  Not
> packaging it also seems fine; Debian's support for non-systemd
> configurations is at best marginal at this point, and while I'm not a
> fan of systemd, I'm also a realist...
>=20
> What do folks think?
>=20
>                    - Ted
