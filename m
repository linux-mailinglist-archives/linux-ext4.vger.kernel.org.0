Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2840B5709
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfIQUgs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 16:36:48 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:48921 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726668AbfIQUgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 16:36:47 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 32FB5776DD;
        Tue, 17 Sep 2019 22:36:45 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Date:   Tue, 17 Sep 2019 22:36:45 +0200
Message-ID: <5330121.x9kUHU8cTX@merkaba>
In-Reply-To: <20190917162137.GA27921@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <20190917155743.GB31567@gardel-login> <20190917162137.GA27921@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Willy Tarreau - 17.09.19, 18:21:37 CEST:
> On Tue, Sep 17, 2019 at 05:57:43PM +0200, Lennart Poettering wrote:
> > Note that calling getrandom(0) "too early" is not something people
> > do
> > on purpose. It happens by accident, i.e. because we live in a world
> > where SSH or HTTPS or so is run in the initrd already, and in a
> > world
> > where booting sometimes can be very very fast.
> 
> It's not an accident, it's a lack of understanding of the impacts
> from the people who package the systems. Generating an SSH key from
> an initramfs without thinking where the randomness used for this could
> come from is not accidental, it's a lack of experience that will be
> fixed once they start to collect such reports. And those who
> absolutely need their SSH daemon or HTTPS server for a recovery image
> in initramfs can very well feed fake entropy by dumping whatever they
> want into /dev/random to make it possible to build temporary keys for
> use within this single session. At least all supposedly incorrect use
> will be made *on purpose* and will still be possible to match what
> users need.

Well I wondered before whether SSH key generation for cloud init or 
other automatically individualized systems could happen in the 
background. Replacing a key that would be there before it would be 
replaced. So SSH would be available *before* the key is regenerated. But 
then there are those big fast man in the middle warnings… and I have no 
clear idea to handle this in a way that would both be secure and not 
scare users off too much.

Well probably systems at some point better have good entropy very 
quickly… and that is it. (And then quantum computers may crack those 
good keys anyway in the future.)

-- 
Martin


