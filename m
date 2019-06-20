Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A626E4CCE5
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFTL3P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 07:29:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39988 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTL3P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 07:29:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so1505068pfp.7;
        Thu, 20 Jun 2019 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZR2EmR3YlisDHpD1diR99wzoWVPTuiYir7pS7ItWvo=;
        b=qOtxoFLNiOj2LW86NORV5oEeYSLlS+JrDFAJ4//TmGpknvcAMGZmI5WbdvOgqsYPJR
         OrvSuPi5Fltt+sLSANlrYm/2FA+3lUvIWjmQcumAU16GiF9XeY6P4W4M6s3a26tkvaZQ
         LHh1W2nN3+RBF7FygSPe6KKeQNBJsXDrQOWIwBFrm7xSzqWjxGrbzl2Epd86OWBHtSlO
         VMyHI9gJyBtS/yhFhxQfG6weJnZNfTM0rlAMW6H91PorsMXWEvV8MsqJPrNSB+bI2ahC
         m75G5x+wdbiHyqjd0HKO/Af+0dSmV5bFFeHdwguPB1c2fdsIVsxPWkba//0eM9WDDkeK
         FKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZR2EmR3YlisDHpD1diR99wzoWVPTuiYir7pS7ItWvo=;
        b=uKn91TpD6YHg3zTrnFd0FvEAIEK+HBzRVi//17QWww7EC1+0hz/iOioWBUucGZPdOJ
         yEJ7ThhQLX/VmJYQ/APgO8S9Q0kKDTborZqDGeGVPQ0uqRo7kXYC/ESiWHOPWZbN03xu
         VEpeC6Q/VlEYPCyJvfDNkAweCKnnxcNSpzHI8Qu8h/EWrowXy6W2VF+7sFspzUDo0tX1
         /OC/xa7JcLlrM21TbsLdmMcozSI/nEdIf46D11T87QKDaMMwdyLAVd33U8TR2gc3DZ8b
         qimMP5NbuDwe0JePVdDdmSmdTEmv23+IXJMtM3pFKw2KNo97+PHehwUH0ZKdgFZJ333Q
         IHGg==
X-Gm-Message-State: APjAAAVZdBMZI+24WvBCbYUmoQKQ9EhljeE14V/CXqqL26K+YuNteGKK
        8BjqeaImFYXG66+HqyM+L2w=
X-Google-Smtp-Source: APXvYqzqXhagpsoe+7KfJWjUy5MEkugB+a+2VB7I8sGUFNxFsqDv4QaUfWXs8HoMemOhro2ki6RGWw==
X-Received: by 2002:aa7:8188:: with SMTP id g8mr77676229pfi.221.1561030154317;
        Thu, 20 Jun 2019 04:29:14 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id a186sm24735797pfa.188.2019.06.20.04.29.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 04:29:13 -0700 (PDT)
Date:   Thu, 20 Jun 2019 19:29:03 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190620112903.GF15846@desktop>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616200154.GA7251@mit.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 16, 2019 at 04:01:54PM -0400, Theodore Ts'o wrote:
> On Sun, Jun 16, 2019 at 10:44:40PM +0800, Eryu Guan wrote:
> > On Wed, Jun 12, 2019 at 02:40:33PM -0400, Gabriel Krisman Bertazi wrote:
> > Test looks good to me, and test passes for me with v5.2-rc4 kernel and
> > latest e2fsprogs, thanks! Just that, I moved the test to generic, as we
> > have all the needed _require rules ready to _notrun on unsupported fs,
> > so it's ready to be generic. (Sorry I was not involved with the
> > ext4-shared-generic discussion in the first place)
> 
> Just to clear up my confusion, what's the distinction between shared
> and generic?  Is it that if there are explicit "only run this test on
> file systems xxx, yyy, and zzz declarations", then it should be
> shared, and otherwise it should be in generic?
> 
> 						- Ted

IMO, shared tests are generic tests that don't have proper _require
rules, so they're hard-coded with explicit "_supported_fs xxx yyy". With
proper _require rules, there should be no shared tests at all, and we'd
try avoid adding new shared tests if possible.

Thanks,
Eryu
