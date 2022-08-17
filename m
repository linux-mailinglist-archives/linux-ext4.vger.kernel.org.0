Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911E4596EAC
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiHQMm7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiHQMmz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 08:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B28993B
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 05:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69129611E4
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 12:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA10BC433D6
        for <linux-ext4@vger.kernel.org>; Wed, 17 Aug 2022 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660740173;
        bh=n6eVTxI+Ys1XiBjEOHQQgpd7o3rSKDT1JeHQdmfEu9Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=D1KWvfskW3mxDHyIYCc+Zr92Za755yQ6+flCj3A6aipDM0AmsLMphdjsBxTzAmFdY
         KBb8RNZ05yyNtVo2dSf43Ph8yLYgbN0at1j34vwz+2EHvCVUpXTHPzv6oy31wcjtdG
         /dNJzFq5vCeqdEEXKfeHzfvC6v+/PcwKh/gN0AnQptqLQih3hmFkm5FRE2zt8iNWVU
         A75PXgV5YrlI8yB1eCRVAQcF/yikTeP28oaGK9Mb8ks/iL99O5FUNXxZzPfx/mu1WQ
         tJ4UrQUWY067NReElrrh5H22U22VBHSkAd+SE+jstA8paTa9b5pXYIEHzUStEDWYVu
         /Gpu+I5KnV2sw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B67EDC433E4; Wed, 17 Aug 2022 12:42:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Wed, 17 Aug 2022 12:42:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangboyang.id@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216283-13602-x63cYmIpjj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216283-13602@https.bugzilla.kernel.org/>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216283

--- Comment #10 from Zhang Boyang (zhangboyang.id@gmail.com) ---
Hi,

On 2022/8/2 11:25, Dave Chinner wrote:
>> I don't particularly worry about "responsible disclosure" because I
>> don't consider fuzzed file system crashes to be a particularly serious
>> security concern.  There are some crazy container folks who think
>> containers are just as secure(tm) as VM's, and who advocate allowing
>> untrusted containers to mount arbitrary file system images and expect
>> that this not cause the "host" OS to crash or get compromised.  Those
>> people are insane(tm), and I don't particularly worry about their use
>> cases.
>=20
> They may be "crazy container" use cases, but anything we can do to
> make that safer is a good thing.
>=20
>=20
> But if the filesystem crashes or has a bug that can be exploited
> during the mount process....
>=20

I think filesystem-safety is very import to consumer devices like=20
computers or smartphones, at least for those filesystems designed for=20
(or widely used for) data exchange, like fat and exfat. Please see my=20
comments below.

On the other hand, filesystem designed for internal use like ext4 or xfs=20
can ignore deliberate manipulation but users still expect they can deal=20
with random errors, e.g. you don't want whole file server down because=20
of single faulty disk. And this has nothing to do with containers.


>> If you have a Linux laptop with an automounter enabled it's possible
>> that when you plug in a USB stick containing a corrupted file system,
>> it could cause the system to crash.  But that requires physical access
>> to the machine, and if you have physical access, there is no shortage
>> of problems you could cause in any case.
>=20
> Yes, the real issue is that distros automount filesystems with
> "noexec,nosuid,nodev". They use these mount options so that the OS
> protects against trojanned permissions and binaries on the untrusted
> filesystem, thereby preventing most of the vectors an untrusted
> filesystem can use to subvert the security of the system without the
> user first making an explicit choice to allow the system to run
> untrusted code.
>=20
> But exploiting an automoutner does not require physical access at
> all. Anyone who says this is ignoring the elephant in the room:
> supply chain attacks.guarantee
>=20
> All it requires is a supply chain to be subverted somehere, and now
> the USB drive that contains the drivers for your special hardware
> from a manufacturer you trust (and with manufacturer
> trust/anti-tamper seals intact) now powns your machine when you plug
> it in.
>=20
> Did the user do anything wrong? No, not at all. But they could
> have a big problem if filesystem developers don't care about
> threat models like subverted supply chains and leave the door wide
> open even when the user does all the right things...
>=20

Yes, an attack need physical access doesn't means the attacker need=20
physical access.

USB sticks (or more generally, external storage devices), is still a=20
very important way to exchange data between computers (and/or smart=20
devices), although it's not as common as before. No safe guarantee here=20
means there is no way to even read untrusted filesystems without using=20
virtual machines / DMZ machines. Thus, using untrusted filesystems=20
natively will become "give root privilege to those who wrote to that=20
filesystem". That makes me recall the nightmare of autorun.inf worms on=20
Windows platforms. I think no user/vendor really want this. At least I'm=20
sure it would be scandal for Tesla if their cars can be hacked by=20
inserting a USB stick.

Best Regards,
Zhang Boyang

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
