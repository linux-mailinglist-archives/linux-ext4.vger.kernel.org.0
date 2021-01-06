Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E324B2EC640
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 23:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbhAFWdK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 17:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAFWdK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jan 2021 17:33:10 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E8C061575;
        Wed,  6 Jan 2021 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MjlhtoRBOMfzhUVUmG0+iEXQeodWN4HZDACnarZYnck=; b=ZZLyhOf+J7x/zOv8hnmFBHtzL
        cc+/rJuG25s7LdDmso8Z8h+Q+mPmAcc8ZHV6rUYJFsNiGAP3CJ9Xp5UhN1+reaQVG1Ch5G3lNxSP6
        h3JDDVYJvVW2JsSN28nHyYxSZ8/sgfKEp6huQp6LuSeUo/WUzXOFW3ZTolC6CukOeytjRBxMJi2P4
        LMn551n6fQf3qf6mPugviEo3NfHOo19UMmkgUlxPLoPz5yKLfN3AqS0jrDwZGTpNdZIBhakAxSj8X
        DjSI/G+63j1Tytvk11nD8CwfkTLc7lJ35k30hpPtE2SKMbKynKGXoOhLn8Do0Bpv1rjjttwn5rCyl
        BaEmMG/ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45198)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kxHLs-00025V-VB; Wed, 06 Jan 2021 22:32:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kxHLr-0000aV-Px; Wed, 06 Jan 2021 22:32:23 +0000
Date:   Wed, 6 Jan 2021 22:32:23 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210106223223.GM1551@shell.armlinux.org.uk>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106172033.GA2165@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 05:20:34PM +0000, Will Deacon wrote:
> With that, I see the following after ten seconds or so:
> 
>   EXT4-fs error (device sda2): ext4_lookup:1707: inode #674497: comm md5sum: iget: checksum invalid
> 
> Russell, Mark -- does this recipe explode reliably for you too?

I've been working this evening on tracking down what change in the
Kconfig file between your working 5.10 kernel binary you supplied me,
and my failing 5.9 kernel.

I've found that _enabling_ CONFIG_STACKPROTECTOR appears to mask the
inode checksum failure problem, at least from a short test.) I'm going
to re-enable CONFIG_STACKPROTECTOR and leave it running for longer.

That is:

CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y

appears to mask the problem

# CONFIG_STACKPROTECTOR is not set

appears to unmask the problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
