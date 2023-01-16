Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9BB66BDE7
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 13:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAPMdv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 07:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAPMdr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 07:33:47 -0500
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 04:33:45 PST
Received: from leela.pocnet.net (leela.pocnet.net [87.193.61.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EE1E1F2
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 04:33:44 -0800 (PST)
Received: from smtpclient.apple (imini.pocnet.net [192.168.59.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: poc)
        by leela.pocnet.net (Postfix) with ESMTPSA id C4AB7280B37;
        Mon, 16 Jan 2023 13:25:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pocnet.net; s=m201510;
        t=1673871909; bh=MSVcBm2d3wqcU1farQ04cleGT3D/nU0AcOMAHyfHpto=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=n2RIVdo1Yo7EZTREnvlI8utLwAPs7CavuTwvF0UYlZZQk7nJ1Kj0gE2kFh3+UPDf9
         PlMl7yxubdz9Hdm1hB9kncZ3GJAmA0zR2UXm063Z38TZ3tYgubw/Zqjxapxq44Pel3
         V8wbrXjwcgQPQV3K+c83buU9ZCfn1ofHAZ2Y4dLE=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: ext4: Remove deprecated noacl/nouser_xattr options
From:   Patrik Schindler <poc@pocnet.net>
In-Reply-To: <20230116104254.xpphncpzu3zf53va@quack3>
Date:   Mon, 16 Jan 2023 13:25:07 +0100
Cc:     linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C7004E8-E732-40C1-B0DD-2A2290E43AC5@pocnet.net>
References: <A5F622F8-99CF-4C7D-8811-7D82DB1C8846@pocnet.net>
 <20230116104254.xpphncpzu3zf53va@quack3>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan,

thanks for your kind response.


Am 16.01.2023 um 11:42 schrieb Jan Kara <jack@suse.cz>:

> On Sun 15-01-23 23:56:21, Patrik Schindler wrote:
>> sorry for contacting you directly, but I struggle to find relevant
>> information on this topic.
>=20
> This is best discussed on ext4 development mailing list (added to CC).

Am I required to join that list?

>> In this web page is documented that "noacl" for ext4 is deprecated.
>>=20
>> =
https://patchwork.ozlabs.org/project/linux-ext4/patch/1658977369-2478-1-gi=
t-send-email-xuyang2018.jy@fujitsu.com/
>>=20
>> Do you have some background information at hand why noacl is =
deprecated,
>> and how to get the functionality of noacl after this change?
>=20
> Yes, these options were deprecated for a long time (10 years) and now =
they are removed since nobody complained. The reasoning is in commit =
f70486055ee ("ext4: try to deprecate noacl and noxattr_user mount =
options"):
>=20
> No other file system allows ACL's and extended attributes to be =
enabled or disabled via a mount option.  So let's try to deprecate these =
options from ext4.

Understood.

> And it makes sense to me. It looks a bit strange and dangerous to =
disable (part of) permission checks for the files. What usecase did you =
have for it?

I'm using Debian Linux 11.

When copy Files from my Mac via Samba to ext4 volumes, ACLs get added. =
(Much) earlier, this wasn't the case, and just UNIX permissions were in =
effect. For me, UNIX permissions are totally sufficient, and I can =
easily see what's going on with ls -l. For ACLs, I need to individually =
fiddle with get/setfacl.

This feels cumbersome to me and gives me a sense not having immediate =
control over access rights. Thus I'd like to find a way to get the =
previous behavior back. Ideally without recompiling samba to remove ACL =
support, as outlined here: =
https://serverfault.com/questions/828977/how-can-i-stop-samba-from-writing=
-extended-acls

For a very long time I had noacl in my fstab but with the update to =
Debian 11, I saw the message about the deprecation. Not sure when I =
observed ACLs being actually written by Samba, though.

In addition, even newer Google hits almost entirely state "noacl in =
fstab to suppress ACLs for ext4", so I'm probably not the only one =
trying to disable them and people largely failed to understand that =
noacl has no effect anymore.

Thanks!

:wq! PoC

