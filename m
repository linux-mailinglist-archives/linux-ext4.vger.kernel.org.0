Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A571A81A9
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 17:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437157AbgDNPLb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440246AbgDNPLH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Apr 2020 11:11:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEAC061A0C
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 08:11:07 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id ef12so6329333qvb.11
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lePIBeP+/+RqgBx2vwurCX1/Io8vCDERHLvSF7u9v34=;
        b=bKhU07FdadFzrp/GlEtWk9FKtU4AtSpBtfZV8FaJ4s6lP1eXhGTcV94v7k0lt+kw2n
         2nzsAZ+ZMjLMmDdP7s76vTCon9INj0reDcGKDQBXcBVkN1hOnQrHJFF8dX2UR2fG4KgH
         oqUwI90QoOTQyl6LqHKzL3bCtSNl42ArTKjouYtIM6ghGbrDBet8AxgNEzbIrGrDFP4H
         VWzpV1hxgQfus5ONSTRLet1pMK1FmkSiUuPOcNQ/TA73YStNFq94eEAyF0RJLdgpylY1
         /d7xudxyaNpdxmQiNfOYNkxpPTUZD+8Cekmp3gRuQVv2q5U0mGo/UkcVg5ZRNaKG9piZ
         ek3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lePIBeP+/+RqgBx2vwurCX1/Io8vCDERHLvSF7u9v34=;
        b=Gn7eMOT4BqxE6MPrpmDn62RiJRP+B4goh9Ydf9Ljx1rNodw4QuCj2XaoBEV/GZSL4R
         fdYJ8CgoaxYU67SOtXZna6jQWOFjmqLIGkWijLyMyAckXgk4Wysf7MxIXj3dEKew2QOp
         nZ59ZcO3oNM0gKfLbyfRkt/5/snJsfX0XxVMTKf1VKgNVx7jciGk5XGCmbj4ixgAZQqT
         zs++1shS+LPgLvXnrWGIJaiImoqIlApyluPPdcFxYnhasEgOrvb2gZRpZ/Yt+b3Dky6e
         D7H18a/kiz9HQB/utN0ICtYmytY3orNSQmDB4qYeSWX8u4IFe9e0pA8UBTvrXVDi/j04
         cwjg==
X-Gm-Message-State: AGi0Pua7Z95ea6rrX0x7y/vDsSGGOXnsZElHAAXHgYZB9pJAnydknAF3
        7cp7E/IyigOsAipLtUGlpGw=
X-Google-Smtp-Source: APiQypJ3EUQ0SilvXEA6aNjBxTKMRH5PLkc12Dno45Wj9AFPtQaWJ5FClULlD5ktwBAV1EYiEoZemA==
X-Received: by 2002:ad4:4507:: with SMTP id k7mr477908qvu.40.1586877066823;
        Tue, 14 Apr 2020 08:11:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id d23sm7540867qkj.26.2020.04.14.08.11.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 08:11:06 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:11:04 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: generic/456 regression on 5.7-rc1, 1k test case
Message-ID: <20200414151104.7x4ywbmvkkdjo6ix@localhost.localdomain>
References: <20200413201211.wbcotcr6rg523wzs@localhost.localdomain>
 <20200414034906.5CB8211C054@d06av25.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414034906.5CB8211C054@d06av25.portsmouth.uk.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ritesh Harjani <riteshh@linux.ibm.com>:
> Hello Eric,
> 
> On 4/14/20 8:22 AM, Ritesh Harjani wrote:
> > Hello Eric,
> > 
> > On 4/14/20 1:42 AM, Eric Whitney wrote:
> > > I'm seeing consistent failures for generic/456 while running
> > > kvm-xfstests' 1k
> > > test case on 5.7-rc1.  This is with an x86-64 test appliance root
> > > file system
> > > image dated 23 March 2020.
> > > 
> > > The test fails when e2fsck reports "inconsistent fs: inode 12, i_size is
> > > 147456, should be 163840".
> > > 
> > > Bisecting 5.7-rc1 identified the following patch as the cause:
> > > ext4: don't set dioread_nolock by default for blocksize < pagesize
> > > (626b035b816b).  Reverting the patch in 5.7-rc1 reliably eliminates
> > > the test
> > > failure.
> > > 
> > 
> > Since you could reliably reproduce it. Could you please try with this
> > patch and see if this fixes it for you?
> > 
> > https://patchwork.ozlabs.org/project/linux-ext4/patch/20200331105016.8674-1-jack@suse.cz/
> 
> 
> Ok, so after updating the xfstests to latest, I could reliably reproduce
> generic/456 failing on x86 with 1K blocksize on my setup too.
> Although, with my limited testing, I couldn't see this issue on Power (where
> blocksize == 4K and PAGESIZE=64K).
> 
> But either ways, after applying above patch the tests always passes for
> me (tested on x86). So this should indeed fix your reported problem.
> Saw an email too that Ted has now picked up this patch.
> 
> 
> -ritesh
>

Hi, Ritesh:

Thanks for pointing out that patch - I'd not noticed it.  Out of general
thoroughness, I applied it to 5.7-rc1 and ran the entire 1k test case
without a generic/456 failure or any other regressions.  So, that should
resolve this issue.  (5.7-rc1 otherwise looks good to me generally after
regression against 5.6 on x86_64).

Thanks very much for your help!

Eric

