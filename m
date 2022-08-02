Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279095874F3
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 03:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiHBBG7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Aug 2022 21:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiHBBG6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Aug 2022 21:06:58 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305881FCD8
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 18:06:57 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27216d5Q009795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Aug 2022 21:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659402402; bh=N4XA8UxqTt4WzZOVbUzEChIx6xTIt/EnZXrChYkBfXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VGWKv1T6BhwSR9IwYVK9qATilhjWyqcERs63QYi0KpDHgube6POjTm2xjzljth0xF
         ZKSpUDxUNjeeDb2U4fuV0T94UPYeIGPb4syFquHDsRCGe72MqRcRPezek1bOu1hFA0
         4LvbRcGVWAQ20btYIQc17axBjvEhBtLeDBZCikfWEgVvrlOFSnfEJpj/AQZ2LCN5b6
         GUURYDjKc9VY2lDgx2WzB8JqeBPT5i7x3v5glKAwIqOJNKpi8RqKqfYcfg9WIO3bz5
         7L5zMKEJwxON/wOXuFJRMakRfUnI+fAMNISIgMYq+WMhLTdvmOipZW7nAvVQKy4ymO
         9G14X4utRXp1A==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 964BD8C2E44; Mon,  1 Aug 2022 21:06:39 -0400 (EDT)
Date:   Mon, 1 Aug 2022 21:06:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <Yuh4n60F3i/KBTTV@mit.edu>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area>
 <20220728072510.yunkzplfqx2vt4wb@fedora>
 <20220801224551.GA3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801224551.GA3861211@dread.disaster.area>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 02, 2022 at 08:45:51AM +1000, Dave Chinner wrote:
> 
> On systems that automount filesytsems when you plug in a USB drive
> (which most distros do out of the box) then a crash bug during mount
> is, at minimum, an annoying DOS vector. And if it can result in a
> buffer overflow, then....

You need physical access to plug in a USB drive, and if you can do
that, the number of potential attack vectors are numerous.  eSATA,
Firewire, etc., gives the potential hardware device direct access to
the PCI bus and the ability to issue arbitrary DMA requests.  Badly
implemented Thunderbolt devices can have the same vulnerability, and
badly implemented USB controllers have their own entertaining issues.
And if attackers have a bit more unguarded physical access time, there
are no shortage of "evil maid" attacks that can be carried out.

As far as I'm concerned a secure system has automounters disabled, and
comptent distributions should disable the automounter when the laptop
is locked.  Enterprise class server class machines running enterprise
distros have no business having the automounter enabled at all, and
careful datacenter managers should fill in the USB ports with epoxy.
For more common sense tips, see:
https://www.youtube.com/watch?v=kd33UVZhnAA

Look, bad buys have the time and energy to run file system fuzzers
(many of which are open source and can be easily found on github).
I'm sure our good friends at the NSA, MSS, and KGB know all of this
already; and the NSO group is apparently happy to make them available
to anyone willing to pay, no matter what their human rights record
might be.

Security by obscurity never works, and as far as I am concerned, I am
grateful when academics run fuzzers and report bugs to us.  Especially
since attacks which require physical access or root privs are going to
have low CVE Security Scores *anyway*.

Cheers,

						- Ted
