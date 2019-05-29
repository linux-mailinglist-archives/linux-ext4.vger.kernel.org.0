Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08892D469
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 06:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfE2EIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 00:08:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2EIE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 00:08:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 61273607C3; Wed, 29 May 2019 04:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559102883;
        bh=REglHIWHwgfNhMT0rLnIMvEPmMM5hOuJ3s1r/dbgRo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+CX3D0SMzysn6MfMG5ngQ3cZcgtq8duQmJDSXhDqKNDLQZjXVFGM0Qe07bgNAVqp
         QcVoJOqycGWUjLoS/5qBKXTCKT8gP9dEoSYuqUC2yRY4Y3rSLDii8mUfcfusXhgkwb
         P+1+lTJQrP9SbEci/6g7qqh0zkKCiDnq1iAkBIEE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 721256063A;
        Wed, 29 May 2019 04:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559102882;
        bh=REglHIWHwgfNhMT0rLnIMvEPmMM5hOuJ3s1r/dbgRo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1QiGFMQ4ErzCB/rqjBaswSDBReI6DQKXarbUdovxifgk+eH522ExxdJcJrD9AgiQ
         gA9Nu75ec8fAErMp4qMSYvpFQtEy7LBUX79nTpLkmmc8J8K0ojZVOtZ7X5IaD/8TdS
         caq+K3/FjWheOUX48RvzV55HbdjoMkZalfvZndww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 721256063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 29 May 2019 09:37:58 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190529040757.GI10043@codeaurora.org>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
 <20190528034830.GH10043@codeaurora.org>
 <20190528131356.GB19149@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528131356.GB19149@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Tue, May 28, 2019 at 09:13:56AM -0400, Theodore Ts'o wrote:
> On Tue, May 28, 2019 at 09:18:30AM +0530, Sahitya Tummala wrote:
> > 
> > Yes, but fsync_mode=nobarrier is little different than
> > a general nobarrier option. The fsync_mode=nobarrier is
> > only controlling the flush policy for fsync() path, unlike
> > the nobarrier mount option which is applicable at all
> > places in the filesystem.
> 
> What are you really trying to accomplish with fsync_mode=nobarrier?
> And when does that distinction have a difference?
> 

Thanks for your time and reply on this.

Here is what I think on these mount options. Please correct me if my
understanding is wrong.

The nobarrier mount option poses risk even if there is a battery
protection against sudden power down, as it doesn't guarantee the ordering
of important data such as journal writes on the disk. On the storage
devices with internal cache, if the cache flush policy is out-of-order,
then the places where FS is trying to enforce barriers will be at risk,
causing FS to be inconsistent. 

But whereas with fsync_mode=nobarrier, FS is not trying to enforce
any ordering of data on the disk except to ensure the data is flushed
from the internal cache to non-volatile memory. Thus, I see this
fsync_mode=nobarrier is much better than a general nobarrier. And it
provides better performance too as with nobarrier but without
compromising much on FS consistency. 

I do agree with all your points below on sudden power down scenarios,
but if someone wants to take a risk, then I think fsync_mode=nobarrier
may be better to enable based on their need/perf requirements.

Thanks,

> What sort of guarantees are you trying to offer, given a particular
> hardware and software design?
> 
> I gather that fsync_mode=nobarrier means one of two things:
> 
>   * "screw you, application writer; your data consistency means nothing to me",
> 
> OR
> 
>   * "we have sufficient guarantees --- e.g., UPS/battery protection to
>     guarantee that even if we lose AC mains, or the user press and holds
>     the power button for eight seconds, we will give storage devices a
>     sufficient grace period to write everything to persistent storage.  We
>     also have the appropriate hardware to warn of an impending low-battery
>     shutdown and software to perform a graceful shutdown in that eventuality."
> 
> If it's the latter, then nobarrier works just as well --- even better.
> 
> If it's the former, *why* is it considered a good thing to ignore the
> requests of userspace?  And without any hardware assurances to provide
> a backstop against power drop, do you care or not care about file
> system consistency?
> 
> Why do you want the distinction between fsymc_mode=nobarrier and
> nobarrier?  When would this distinction be considered a good thing?
> 
> 	    	       	    		   - Ted
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
