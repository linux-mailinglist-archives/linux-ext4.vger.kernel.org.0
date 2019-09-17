Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B491B571D
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfIQUo3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 16:44:29 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:37695 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726668AbfIQUo3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 16:44:29 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id AAB4C776E2;
        Tue, 17 Sep 2019 22:44:25 +0200 (CEST)
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
Date:   Tue, 17 Sep 2019 22:42:57 +0200
Message-ID: <2119167.1ishuQyBJ6@merkaba>
In-Reply-To: <20190917172929.GD27999@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <20190917171328.GA31798@gardel-login> <20190917172929.GD27999@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Willy Tarreau - 17.09.19, 19:29:29 CEST:
> On Tue, Sep 17, 2019 at 07:13:28PM +0200, Lennart Poettering wrote:
> > On Di, 17.09.19 18:21, Willy Tarreau (w@1wt.eu) wrote:
> > > On Tue, Sep 17, 2019 at 05:57:43PM +0200, Lennart Poettering 
> > > wrote:
> > > > Note that calling getrandom(0) "too early" is not something
> > > > people do
> > > > on purpose. It happens by accident, i.e. because we live in a
> > > > world
> > > > where SSH or HTTPS or so is run in the initrd already, and in a
> > > > world
> > > > where booting sometimes can be very very fast.
> > > 
> > > It's not an accident, it's a lack of understanding of the impacts
> > > from the people who package the systems. Generating an SSH key
> > > from
> > > an initramfs without thinking where the randomness used for this
> > > could come from is not accidental, it's a lack of experience that
> > > will be fixed once they start to collect such reports. And those
> > > who absolutely need their SSH daemon or HTTPS server for a
> > > recovery image in initramfs can very well feed fake entropy by
> > > dumping whatever they want into /dev/random to make it possible
> > > to build temporary keys for use within this single session. At
> > > least all supposedly incorrect use will be made *on purpose* and
> > > will still be possible to match what users need.> 
> > What do you expect these systems to do though?
> > 
> > I mean, think about general purpose distros: they put together live
> > images that are supposed to work on a myriad of similar (as in: same
> > arch) but otherwise very different systems (i.e. VMs that might lack
> > any form of RNG source the same as beefy servers with muliple
> > sources
> > the same as older netbooks with few and crappy sources, ...). They
> > can't know what the specific hw will provide or won't. It's not
> > their incompetence that they build the image like that. It's a
> > common, very common usecase to install a system via SSH, and it's
> > also very common to have very generic images for a large number
> > varied systems to run on.
> 
> I'm totally file with installing the system via SSH, using a temporary
> SSH key. I do make a strong distinction between the installation
> phase and the final deployment. The SSH key used *for installation*
> doesn't need to the be same as the final one. And very often at the
> end of the installation we'll have produced enough entropy to produce
> a correct key.

Well… systems cloud-init adapts may come from the same template. Cloud 
Init thus replaces the key that has been there before on their first 
boot. There is no "installation".

Cloud Init could replace the key in the background… and restart SSH 
then… but that will give those big fat man in the middle warnings and 
all systems would use the same SSH host key initially. I just don't see 
a good way at the moment how to handle this. Introducing an SSH mode for 
this is still a temporary not so random key with proper warnings might 
be challenging to get right from both a security and usability point of 
view. And it would add complexity.

That said with Proxmox VE on Fujitsu S8 or Intel NUCs I have never seen 
this issue even when starting 50 VMs in a row, however, with large cloud 
providers starting 50 VMs in a row does not sound like all that much. 
And I bet with Proxmox VE virtio rng is easily available cause it uses 
KVM.

-- 
Martin


