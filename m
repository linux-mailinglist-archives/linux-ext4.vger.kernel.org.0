Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C399AB53EB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfIQRUY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:20:24 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:55321 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfIQRUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+s0i10bEB4vQnOoo0VzcFR/k65BOCiuSJCVnsGJdaGE=; b=ZhjxQOojSL5faoWN1n8P5Ypz2
        Cy73nzl8ylH1R+C1DHGdivrc5y5ja/zPnGPalzIwhEg4Y7rQiu8MbyEiX6YWho003IpZoqmyAPcpf
        Ld0ppb5m3uhFtF2Q8f2wGFgK3d47g2F5wcYy9bVS6jJJYLvS8PSssL256eFBFMfRLSbQ0=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1iAH90-0002UO-3t; Tue, 17 Sep 2019 18:20:02 +0100
Date:   Tue, 17 Sep 2019 18:20:02 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Steigerwald <martin@lichtvoll.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917172002.vrkudj2ejtrtl7rh@srcf.ucam.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
 <20190917163456.alzodstm3hd4yrni@srcf.ucam.org>
 <20190917171641.GC27999@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917171641.GC27999@1wt.eu>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 07:16:41PM +0200, Willy Tarreau wrote:
> On Tue, Sep 17, 2019 at 05:34:56PM +0100, Matthew Garrett wrote:
> > On Tue, Sep 17, 2019 at 09:27:44AM -0700, Linus Torvalds wrote:
> > 
> > > Does anybody believe that 128 bits of randomness is a good basis for a
> > > long-term secure key?
> > 
> > Yes, it's exactly what you'd expect for an AES 128 key, which is still 
> > considered to be secure.
> 
> AES keys are for symmetrical encryption and thus as such are short-lived.
> We're back to what Linus was saying about the fact that our urandom is
> already very good for such use cases, it should just not be used to
> produce long-lived keys (i.e. asymmetrical).

AES keys are used for a variety of long-lived purposes (eg, disk 
encryption).
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
