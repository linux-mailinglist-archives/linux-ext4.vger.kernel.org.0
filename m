Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D181D667A
	for <lists+linux-ext4@lfdr.de>; Sun, 17 May 2020 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgEQHzK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 May 2020 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEQHzK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 May 2020 03:55:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBAC061A0C
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 00:55:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f4so3187964pgi.10
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=d4wODvUhziDv4aQpTlSW7cQ+hc8dpNgw83iOU8xe4uk=;
        b=WQw+oCYp6bK7/sEc7Kx9XxW2J/zWSp3layTZMn6BCl9NjRFvyQqaxkUHZAnwpyOO9Z
         ywNh5176pfmf03FiFmJHl4eA8rjpjoQHL8B/50vl8wvK9ez0CtXEMLuulZ8kPpSppNi/
         LnecrFwMqYhSO5nwhZzN6dUfzZs7HnjZeC3yMfBFoP5el+PzpAQ+6vxO4YD+JbY33XjG
         nhidlecmf1i/oTeUu5o9JSDnfMEb78Io54JYczGEq5RvUbgWLODQCC3Il5SlkiGuOPGE
         GWhJ6LS5XgxDvZioaj2rOVRxhrTTB6dkMxKPCW9ad9CFiBBADf2VJ0amALHkgF9t4jzA
         SK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=d4wODvUhziDv4aQpTlSW7cQ+hc8dpNgw83iOU8xe4uk=;
        b=AIeELoaBbnIVrvuKa87+njpNGzGpkt962G0m0aOHua6Tb/ngdEIYSJBKY+vRgDyo8q
         Xi/xGM7yi8MsLiKBhHKPG+XE+7BUHWxm60vZIUBG+TGi+/OCn3FKUQ4/dfQWhDMrhqqL
         7zPdvSzjNaqb/2MPXQIOqyBLkVUUOflxlqGsWWZkVLe2VHsFwMAxlg2S/PsmgZGJwk1/
         yQ4y0gDgyUpbHM5PujNJwijd4NItVJpryLuppOkBGbgLBqWfzcyYqmUcZeU6j8138P0Z
         AhsJ+app0Fgj33JBIVupVRrx3ZrqAHpMpR7XKwNb+VBv7d1I1p3L+QobqBpMzMiklw2w
         InrQ==
X-Gm-Message-State: AOAM532cK5p/84Rpo0VWHAdHU24CfTJcLWpGrxqPikbq3MqvXPDuGAN6
        5sJ/1h1SjHgtuq8+GkXlqoHknleQH6iZgw==
X-Google-Smtp-Source: ABdhPJwvNprDJF9zyunPghIztinnFxV3g+1a+yyaca+ri+1jFf2NbDwUuRRJ1M/Vkj1z9G4tLhYF5w==
X-Received: by 2002:a63:5b41:: with SMTP id l1mr10051521pgm.88.1589702109683;
        Sun, 17 May 2020 00:55:09 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id cx11sm5539214pjb.36.2020.05.17.00.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 00:55:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3BA1CBB1-77DB-43C8-A9CD-A3B85223F86F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D9442292-9CC2-4651-B1E8-BC75A897C659";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Date:   Sun, 17 May 2020 01:55:07 -0600
In-Reply-To: <914597DA-395A-47A5-A8D6-DFCE2D674289@whamcloud.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
References: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
 <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
 <914597DA-395A-47A5-A8D6-DFCE2D674289@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D9442292-9CC2-4651-B1E8-BC75A897C659
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On May 15, 2020, at 2:56 AM, Alex Zhuravlev <azhuravlev@whamcloud.com> wrote:
> On 14 May 2020, at 13:04, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>>> +		/* cr=0/1 is a very optimistic search to find large
>>> +		 * good chunks almost for free. if buddy data is
>>> +		 * not ready, then this optimization makes no sense */
>> 
>> I guess it will be also helpful to mention a comment related to the
>> discussion that we had on why this should be ok to skip those groups.
>> Because this could result into we skipping the group which is closer to
>> our inode. I somehow couldn't recollect it completely.
> 
> Please remind where the discussion took place? I must be missing that.

Alex, this discussion was during the ext4 weekly developer concall.
I can send you the details if you want to join for next week's call.

The summary of the discussion is that Ted was wondering what happens if
one thread was scanning the filesystem and triggering prefetch on the
groups, but didn't find any loaded (so skips cr=0/1 passes completely),
then does an allocation in its preferred group (assuming there is space
available there, what happens to allocations for other inodes after this?

Presumably, the first thread's prefetch has loaded a bunch of groups, and
even if the second thread starts scanning for blocks at its preferred
group (though a different one from the first thread), it will skip all of
these groups until it finds the group(s) from the first inode allocation
are in memory already, and will proceed to allocate blocks there.

The question is whether this is situation is affecting only a few inode
allocations for a short time after mount, or does this persist for a long
time?  I think that it _should_ be only a short time, because these other
threads should all start prefetch on their preferred groups, so even if a
few inodes have their blocks allocated in the "wrong" group, it shouldn't
be a long term problem since the prefetched bitmaps will finish loading
and allow the blocks to be allocated, or skipped if group is fragmented.


Cheers, Andreas



--Apple-Mail=_D9442292-9CC2-4651-B1E8-BC75A897C659
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIyBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7A7dsACgkQcqXauRfM
H+CjaQ/3er6hx4kt0imeFORldGMGuo7I1xFj2PIFYWxrIgK1vZ+9w6V4+T5+hJM4
fHBo4TNelOKD4H+As45sMemh++mm8t/+OU5nfqbrXQg+LGa2rvNHD6sXTyFAVP5E
UiZbPz4xMT+YFXkVkh/neqEYScdcWl6rBCeswvMhqryXHNAna1Vv0+dt4Cgzjz5w
SmKhGgfu5NDNawSLmOexl0PDAEZtV2eBQnxOoG98CEcliG6WIXm6s4P67YPF+Lkr
MdFLRLZ5c1frn2U56KVPqlDnsrpR5kKN2Ds/k5spJKWov/JGZh9Yqfl4xqbWo38j
03Ve7tDkD8X2C/G/GVWcqPUdDswPXlASKvWuH0+J7vtYvIVThscA3iXD+lSmgnSy
sYakoe+GcQvld/9PqqBI+PYw0EeFgPndembzQzLP1VMCisPdQEh1JdiYhpfp2dQB
0TC0fAWvpeMSRLsBu5761tsczTFBk1n7ljBcnRRJzGFYUUv9e2XkvKZp1x+RVHfU
FpCzWsUMBFWKgeaLSMLcZffqyYUf+7ScTbwSExfXJtK5Yvfpbj/N90iG5Sa8cMJ5
q2cXgpeJeme0VifmJFBBz1/lqezBbXzQ4EJ2ye/fOrIllRGdVs+qyoRja55yngKT
4cpTdnGzkP8BCF3Ew8DN3DC/cfTHOPRsBJv0VnvCuQztYjnOJA==
=gf6f
-----END PGP SIGNATURE-----

--Apple-Mail=_D9442292-9CC2-4651-B1E8-BC75A897C659--
