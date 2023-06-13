Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CB072D8BE
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 06:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjFMEsg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 00:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjFMEsg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 00:48:36 -0400
Received: from striker.routify.me (unknown [64.94.212.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286DF13E
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 21:48:35 -0700 (PDT)
Received: from glitch (unknown [IPv6:2602:24c:b8f:cd90::8eb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by striker.routify.me (Postfix) with ESMTPSA id B72ACE34;
        Tue, 13 Jun 2023 04:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 striker.routify.me B72ACE34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=striker-outgoing; t=1686631707;
        bh=3SWM9HpbvhY+6JXsgZEbqdJ7uzmLqwt9dCy2pAjIAms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9OFNliJWYsooYmf4esdOxSlSOzjzXXOFNdtBQRRqJXow8z+fd5nFSnzAtZaLG2f3
         9Cgl0yfTaGG7xNxflDfil9S/SaoKw7b7/Fo1HewXr0qImxl7IqXB/1OHpxh39ml6Z6
         eMg7swj9N5L67o5gIJS+O94x1U2oNyEZ3Wb9EiUE=
Date:   Mon, 12 Jun 2023 21:48:30 -0700
From:   Sean Greenslade <sean@seangreenslade.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <ZIf1HpUjmQWu0xXo@glitch>
References: <ZIauBR7YiV3rVAHL@glitch>
 <ZIa5P1HqE62rmzqu@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZIa5P1HqE62rmzqu@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 12, 2023 at 01:20:47PM +0700, Bagas Sanjaya wrote:
> On Sun, Jun 11, 2023 at 10:32:53PM -0700, Sean Greenslade wrote:
> > Hello, folks.
> >=20
> > I noticed a change in behavior of ext4 in recent kernels. I make use of
> > several luks loopback images formatted as ext4 that I mount read-only
> > most of the time. I use rsync to synchronize the backing images between
> > machines. In the past, mouning the images as read-only would not touch
> > the backing image contents at all, but recently this changed. Every
> > mount, even ones that are RO from the start, will cause some small
> > writes to the backing image and thus force rsync to scan the whole file.
> >=20
> > I confirmed that the issue is still present on v6.4.rc6, so I performed
> > a bisect and landed on the following commit:
> >=20
> > > eee00237fa5ec8f704f7323b54e48cc34e2d9168 is the first bad commit
> > > commit eee00237fa5ec8f704f7323b54e48cc34e2d9168
> > > Author: Ye Bin <yebin10@huawei.com>
> > > Date:   Tue Mar 7 14:17:02 2023 +0800
> > >=20
> > >     ext4: commit super block if fs record error when journal record w=
ithout error
> >=20
> > That certainly looks like a likely cause of my issue, but I'm not
> > familiar enough with the ext4 code to diagnose any further. Please let
> > me know if you need any additional information, or if you would like me
> > to test anything.
> >=20
>=20
> Can you show dmesg when regression happens?
>=20
> Ye: It looks like this regression is caused by your commit. Would you like
> to take a look on it?
>=20
> Anyway, thanks for the bug report. I'm adding it to regzbot:
>=20
> #regzbot ^introduced: eee00237fa5ec8
> #regzbot title: commit super block writes even in read-only filesystems

I did a fresh boot on the 6.4 rc6 kernel and did an RO mount and
unmount. Here's the full dmesg output from that:

[   48.955896] loop0: detected capacity change from 0 to 4194304
[   48.965526] Key type trusted registered
[   48.973640] Key type encrypted registered
[   49.032404] EXT4-fs (dm-0): mounted filesystem 4e824972-4523-407e-b0da-3=
229a71b68d8 ro with ordered data mode. Quota mode: none.
[   61.180755] EXT4-fs (dm-0): unmounting filesystem 4e824972-4523-407e-b0d=
a-3229a71b68d8.
[   61.236958] dm-0: detected capacity change from 4190208 to 0

Thanks,

--Sean

