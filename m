Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED23B5396
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfIQREx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:04:53 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:55191 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfIQREx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:04:53 -0400
X-Greylist: delayed 1758 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 13:04:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LuL5ZI414b9FwKoH6sRw7sESGqD8UiRL/050jKRr87s=; b=tBOsGYkK7q19jjSn61AmmdNm1
        o/JrySduijRGaqcJQxeElc9mBQOrwzlmboHlNZw23tFuNIImhhUD17sz5FoLvEnMVkJm3xjeCRnxM
        eGF1Cqbu+zm6w/r6mp75NInUGtAbolzuQA4Wz5woDMXc+zEuOk1gyYw/pW6vGryUEeuTY=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1iAGRM-00025G-Dj; Tue, 17 Sep 2019 17:34:56 +0100
Date:   Tue, 17 Sep 2019 17:34:56 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>, Willy Tarreau <w@1wt.eu>,
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
Message-ID: <20190917163456.alzodstm3hd4yrni@srcf.ucam.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 09:27:44AM -0700, Linus Torvalds wrote:

> Does anybody believe that 128 bits of randomness is a good basis for a
> long-term secure key?

Yes, it's exactly what you'd expect for an AES 128 key, which is still 
considered to be secure.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
