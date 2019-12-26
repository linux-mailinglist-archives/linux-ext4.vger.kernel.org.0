Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44712AB9E
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 11:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZKVf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 05:21:35 -0500
Received: from cavan.codon.org.uk ([93.93.128.6]:47018 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfLZKVf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 05:21:35 -0500
X-Greylist: delayed 1074 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Dec 2019 05:21:34 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C3mxjaIDMuJTeQyZTd+qCmmlFsqprmMX4F3TTiwzZHM=; b=j8R00hr2GEVsOkbbGEEmt01bYd
        vwA5caOLAxxH/pweQc3aPeaNuRixw7i2grmlD/9PxsIZFK2Hh9sYr11z17uDc9/Fk56hsulaz6mIQ
        QvAS7cNOG3FHxojjB1kadh6cR6NF54E366ltCDtGX32pLpVu7EWuJeBtSUiyyvREzbOQ=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1ikPzS-0003n7-Sm; Thu, 26 Dec 2019 10:03:34 +0000
Date:   Thu, 26 Dec 2019 10:03:34 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] Rework random blocking
Message-ID: <20191226100334.bsh3b3dphs4j4cvx@srcf.ucam.org>
References: <cover.1577088521.git.luto@kernel.org>
 <9872655.prSdhymlXK@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9872655.prSdhymlXK@positron.chronox.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 26, 2019 at 10:29:00AM +0100, Stephan Müller wrote:
> 
> What about offering a compile-time option to enable or disable such code? 
> Note, with the existing random.c code base, there is no need to have a 
> separate blocking_pool. The ChaCha20 DRNG could be used for that very same 
> purpose, provided that in case these true random numbers are generated when 
> the Chacha20 DRNG received an equal amount of "unused" entropy.

I think it's reasonable to offer such an option as long as it's made 
clear that it'll break userland and should only be enabled under very 
weird circumstances. We don't want to end up in a situation where 
userland developers feel that they need to code to handle such 
situations - the only people who care about this distinction should be 
in control of their userland stack and able to cope with the 
consequences.

> If an unprivileged caller requests true random data, at least 1024 bits of 
> entropy is left in the pool. I.e. all entropy above that point is available 
> for this request type. Note, even namespaces fall into this category 
> considering that unprivileged users can create a user name space in which they 
> can become root.

I also feel like describing any of this as "true random data" is 
misleading. Most of our entropy sources are devices that could, given 
sufficient information, be modelled accurately. We're not sampling 
quantum events here.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
