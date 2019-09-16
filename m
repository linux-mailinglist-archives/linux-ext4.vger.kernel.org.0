Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F967B449C
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 01:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfIPXey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 19:34:54 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:47379 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIPXey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 19:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X2q8aSnUy4dy03z0yGFvq5cDtugo9Mv7XGnsBb9G3Bk=; b=iAa4MiEKt/pSuLtIM34u8C1sW
        HHlf+AHi/l5j+B4Z4Z0k+p3U6eMDp91kvCPlrGAlvN7/2pFnerYmrpTlrds1l4uKuu4UD2RIXJv9u
        YW2hP7Ilkey8R69WYU4zMpfFKhHUbErDI/SRqn/q7IpqEli9w4dM4vCXhqDIFc0jB4wfQ=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1iA00g-0001fo-3D; Tue, 17 Sep 2019 00:02:18 +0100
Date:   Tue, 17 Sep 2019 00:02:18 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
References: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
 <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
 <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 10:44:31AM -0700, Linus Torvalds wrote:
>  - admit that the current situation actually causes problems, and has
> _existing_ bugs.
> 
>  - throw it out the window, with the timeout and big BIG warning when
> the problem cases trigger

The semantics many people want for secure key generation is urandom, but 
with a guarantee that it's seeded. getrandom()'s default behaviour at 
present provides that, and as a result it's used for a bunch of key 
generation. Changing the default (even with kernel warnings) seems like 
it risks people generating keys from an unseeded prng, and that seems 
like a bad thing?

It's definitely unfortunate that getrandom() doesn't have a GRND_URANDOM 
flag that would make it useful for the "I want some vaguely random 
numbers but I don't care that much and I don't necessarily have access 
to /dev/urandom" case, but at the moment we have no way of 
distinguishing between applications that are making this call because 
they want the semantics of urandom but need it to be seeded (which is 
one of the usecases getrandom() was introduced for in the first place) 
and applications that are making this call because it was convenient and 
the kernel usually ended up generating enough entropy in the first 
place. Given the ambiguity, I don't see an easy way to solve for the 
latter without breaking the former - and that could have some *very* bad 
outcomes.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
