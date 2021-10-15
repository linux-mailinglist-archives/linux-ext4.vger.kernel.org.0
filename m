Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8642E72B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhJODXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 23:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhJODXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 23:23:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC953C061570
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 20:21:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso8374895pjb.4
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=60or3vuEPmsqaq7yH1XXXm8E4q5ZjYdlhij5/gIRdBc=;
        b=bNK/7mnrIYTOQ3yJucIq9GtM9mKVBviai3UA+DyiJVhHKC8v+gKKXtkp9kdEfQ5HdF
         q6RQmzWUP/2R4aJ4HTvCTdPsZWVYD7CaYc3F3DJDdUGL7i4UgifaTXD2eP/fs0Nh7CGV
         PkeJWLHTXhHMJBt8MvGhZhWm2zOSaIL4saqRaNRDQTMYTwj2+Ehg00voOfExcbAMA1oP
         3F4YlJNHJCTTDZdVarSnxWm0w9EdYVmrTl6wU8oOMHZP+1+60sGp+Q+Ae6xgXc+drfcZ
         cYFcX684UKimuBwzMYclC6A3CxFOlEgETEiNPVjn7aaOYppMyitCvufoPnDcUrmKqhnJ
         08Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=60or3vuEPmsqaq7yH1XXXm8E4q5ZjYdlhij5/gIRdBc=;
        b=al0+hfpNICrL35H4s1T4Vgl64pmU9f5oVK1xk5eUWzRsKmZsduGO1CGSCvfTma79dN
         V9C5atb1mmwezTSN85kUuWl/Y2cuPMXnXi/afWspwiqZJ2h3xKc5fWH1XXVPym5nZing
         AW2blq+1Jfeo8/dUBERcWYUF87gkrGjpEltVYVvWJ4uD9emf7uerXYniAx6vLOngMXGv
         ZucJcaCJWX74MTFgTP5LGpraotoD4WGkVI+dPPsufYx5KQgPjug2sEUoTSsnMqkMVSaf
         JYB9KPYt8pn6IpgyXXf66w3+HKI0p4W+QzIqt2bOSmu2VibFa/RFXcMxYZTEYh/jK6Mr
         gXZw==
X-Gm-Message-State: AOAM533H+B9xyMcTdMzHfHaAbSMFzlRmCBJAIj+ZbTOHw8f1O7BWaDgf
        N5KpcWIMQX2ymZg0+1LaO3WGAu5v79LXgyuu
X-Google-Smtp-Source: ABdhPJxg4Q1I3EI/hvlHb/qsjjKlQgxZk/gCDit++JvTilIAd//QQf6lBOye0sgFhXe7gEVUeTtNGQ==
X-Received: by 2002:a17:90b:782:: with SMTP id l2mr10675893pjz.190.1634268093213;
        Thu, 14 Oct 2021 20:21:33 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x7sm9999637pjl.55.2021.10.14.20.21.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Oct 2021 20:21:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <59CB01CB-8D4F-4712-9A6F-F4EBA6BB0102@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C7104A77-2EBD-4C39-AC6F-84548DE62189";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
Date:   Thu, 14 Oct 2021 21:21:29 -0600
In-Reply-To: <YWdSeMuosYio7TFv@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, yebin <yebin10@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz> <615FA55B.5070404@huawei.com>
 <615FAF27.8070000@huawei.com> <20211012084727.GF9697@quack2.suse.cz>
 <61657590.2050407@huawei.com> <20211013093847.GB19200@quack2.suse.cz>
 <YWdSeMuosYio7TFv@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C7104A77-2EBD-4C39-AC6F-84548DE62189
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 13, 2021, at 3:41 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Wed, Oct 13, 2021 at 11:38:47AM +0200, Jan Kara wrote:
>> 
>> OK, I see. So the race in ext4_multi_mount_protect() goes like:
>> 
>> hostA				hostB
>> 
>> read_mmp_block()		read_mmp_block()
>> - sees EXT4_MMP_SEQ_CLEAN	- sees EXT4_MMP_SEQ_CLEAN
>> write_mmp_block()
>> wait_time == 0 -> no wait
>> read_mmp_block()
>>  - all OK, mount
>> 				write_mmp_block()
>> 				wait_time == 0 -> no wait
>> 				read_mmp_block()
>> 				  - all OK, mount
>> 
>> Do I get it right? Actually, if we passed seq we wrote in
>> ext4_multi_mount_protect() to kmmpd (probably in sb), then kmmpd would
>> notice the conflict on its first invocation but still that would be a bit
>> late because there would be a time window where hostA and hostB would be
>> both using the fs.

It would be enough to have even a short delay between write and read to
detect this case.  I _thought_ there should be a delay in this case,
but maybe it was removed after the patch was originally submitted?

>> We could reduce the likelyhood of this race by always waiting in
>> ext4_multi_mount_protect() between write & read but I guess that is
>> undesirable as it would slow down all clean mounts. Ted?
> 
> I'd like Andreas to comment here.  My understanding is that MMP
> originally intended as a safety mechanism which would be used as part
> of a primary/backup high availability system, but not as the *primary*
> system where you might try to have two servers simultaneously try to
> mount the file system and use MMP as the "election" mechanism to
> decide which server is going to be the primary system, and which would
> be the backup system.
> 
> The cost of being able to handle this particular race is it would slow
> down the mounts of cleanly unmounted systems.

Ted's understanding is correct - MMP is intended to be a backup mechanism
to prevent filesystem corruption in the case where external HA methods
do the wrong thing.  This has avoided problems countless times on systems
with multi-port access to the same storage, and can also be useful in the
case of shared VM images accessed over the network, and similar.

When MMP was implemented for ZFS, a slightly different mechanism was used.
Rather than having the delay to detect concurrent mounts, it instead writes
to multiple different blocks in a random order, and then reads them all.
If two nodes try to mount the filesystem concurrently, they would pick
different block orders, and the chance of them having the same order (and
one clobbering all of the blocks of the other) would be 1/2^num_blocks.
The drawback is that this would consume more space in the filesystem, but
it wouldn't be a huge deal these days.

> There *are* better systems to implement leader elections[1] than using
> MMP.  Most of these more efficient leader elections assume that you
> have a working IP network, and so if you have a separate storage
> network (including a shared SCSI bus) from your standard IP network,
> then MMP is a useful failsafe in the face of a network partition of
> your IP network.  The question is whether MMP should be useful for
> more than that.  And if it isn't, then we should probably document
> what MMP is and isn't good for, and give advice in the form of an
> application note for how MMP should be used in the context of a larger
> system.

One of the existing failure cases with HA that MMP detects is loss of
network connection, so I wouldn't want to depend on that.

Cheers, Andreas






--Apple-Mail=_C7104A77-2EBD-4C39-AC6F-84548DE62189
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmFo87kACgkQcqXauRfM
H+AxqA/+PwbiFucay3xCCPsEWzuRMa3mTU+OiXR2qpUH6euh3C4XwvDwMUOtVD/b
jUPG8K23TETVG4s5tywqlrjdQP04SnnC2yz5zCxkYxI/bSeAFK/ffEIVTvU0S+Qo
L0cGD5k8aY/TFQrnVHzhtHban8fBFKDfeLl/UsjofjILV84ZCdkZSAYmAB39tPlC
gK0iPbWuSEUpEbIUlKzTjKj6qIAuozivSerPhLNEjBnVTcz33L4PZNGujGddug8S
yVLAf+UAhv4wfHP957q0557u/SB//wDFa8/tdjNgrEJe+z4eDUTZrKyIw2XOpZrw
6R9BmMyA4xs+OXsoMA1YWIqnR3W26z0DEVCDfX19VoXqgg9GS3tlDTODG5+z92aG
EW9g7MA9xy9XeoLzKcyqysKaYpZRJXnYKynISbKijZKgDG8XPjosZzX67KGjABzk
uKRrKEmSkANU8+KM28ODVBxAXUpy2DWZ+Ld9Tkh6OC9kryCUWjSa/iD5ow6sIHt3
xOZ57k/Yt4DxWxM3dJPYfd9if9meTqgcjpM4N7CPQGOeQQseI9eJGbiIUZqF7sDU
2Uj5wb7e8vwPH0V4cq+mTfBCNBXxHTKpt7PEi4oYtxmqVH0CxMwKgQreVaYyMesc
yHGFxi07Gb2NXWxnspENhahq+ncTGYIpTglQ3VTDifJGma/Vl40=
=YwMU
-----END PGP SIGNATURE-----

--Apple-Mail=_C7104A77-2EBD-4C39-AC6F-84548DE62189--
