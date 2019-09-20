Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF94B9881
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfITUex (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 16:34:53 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:37083 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfITUex (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 16:34:53 -0400
X-Greylist: delayed 997 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Sep 2019 16:34:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kRB7J4Z1rxbkzW6KajLP7EjJU8aXPe3wlVZKi9gdjP8=; b=POWQbp5eTDGJeeQ57YU37aabB
        ChHE8qiOp92UivtPZsgJYfG9CVQDVNr4ZjbEcdPdLKWTBlT8XDhn3QHR3yqKbLMuQXHiCvOt94iDv
        kPAI7CAYYeR2sf7uqNFh0X3X/XQSu7+V1Ru+So2x83Rx+bVtBGevz4s0bStBeS4431St4=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1iBPLf-0002o2-E8; Fri, 20 Sep 2019 21:17:47 +0100
Date:   Fri, 20 Sep 2019 21:17:47 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>, lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920201747.kmzx2kjdv2hbljsy@srcf.ucam.org>
References: <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc>
 <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
 <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
 <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 12:51:12PM -0700, Linus Torvalds wrote:

> So we absolutely _will_ come up with some way 0 ends the wait. Whether
> it's _just_ a timeout, or whether it's jitter-entropy or whatever, it
> will happen.

FWIW, Zircon uses the jitter entropy generator to seed the CRNG and 
documented their findings in 
https://fuchsia.dev/fuchsia-src/zircon/jitterentropy/config-basic .
-- 
Matthew Garrett | mjg59@srcf.ucam.org
