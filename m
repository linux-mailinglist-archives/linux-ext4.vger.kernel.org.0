Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80110B57CC
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 23:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfIQVwY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 17:52:24 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:58550 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfIQVwY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 17:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ca4Lhweyqz92nJyY4L52arK98MpJ203Gl7QAiPb4ap0=; b=DwTJNUQ8yCEtLTkhaV9aHyfbMN
        O3iKbXNzLDBx8o+KQ5sXbLOi7HA7oif5rLNCgaIu0GA7Ml7qLArYCHiD3MI3Yf1jJ8meJdBPQzkCP
        sooXvUeDqQAHpNlgBE+K8QU5hMqaYVrJQ7boqm7hSTTAV8cirKS+1NdYEH1KYj1EXpsA=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1iALOC-0006gx-Us; Tue, 17 Sep 2019 22:52:00 +0100
Date:   Tue, 17 Sep 2019 22:52:00 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917215200.wtjim3t6zgt7gdmw@srcf.ucam.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <2658007.Cequ2ms4lF@merkaba>
 <20190917205234.GA1765@darwi-home-pc>
 <1722575.Y5XjozQscI@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1722575.Y5XjozQscI@merkaba>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 11:38:33PM +0200, Martin Steigerwald wrote:

> My understanding of entropy always has been that only a certain amount 
> of it can be produced in a certain amount of time. If that is wrong… 
> please by all means, please teach me, how it would be.

getrandom() will never "consume entropy" in a way that will block any 
users of getrandom(). If you don't have enough collected entropy to seed 
the rng, getrandom() will block. If you do, getrandom() will generate as 
many numbers as you ask it to, even if no more entropy is ever collected 
by the system. So it doesn't matter how many clients you have calling 
getrandom() in the boot process - either there'll be enough entropy 
available to satisfy all of them, or there'll be too little to satisfy 
any of them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
