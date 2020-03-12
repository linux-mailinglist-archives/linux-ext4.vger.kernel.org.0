Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD9182D4F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 11:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLKUL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 06:20:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39168 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgCLKUL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 06:20:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id s2so2850736pgv.6
        for <linux-ext4@vger.kernel.org>; Thu, 12 Mar 2020 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjZji4vANWBvK/LYuH8B7sdZ9t4UkGDVwURMSZ9njK8=;
        b=potDI4g+QjXEc9+afuaYX9soMYgDWWQzZz7gVpTfQplIeba8QefsQ40UC+IJO3iIcZ
         z+WmIMzG+S1bxjkqGXJeHLDOii5RqFc0ly1/YhVcLGWxt/enxgD9pGI7dl3LyFyfcDGX
         IDey2/sxN5FsQih8BMd2XjMudopxKgnXjjwz9LmU38rMLKpz0P2pUHevAs8h7wsIaWLC
         YAs6yJS/YBLU3ONShfWTLQORogCpXiKP5gMn7/6GjGsyl36yuV2iWPDSt7cPXbkrEVqs
         w32iKu3xwArajG36huZnBsT3BOwpFW3GdzQ6ghCU75G7KziLxb3M079Dr94tpuj9Sdei
         n58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjZji4vANWBvK/LYuH8B7sdZ9t4UkGDVwURMSZ9njK8=;
        b=QnpaQFH7MRC6M7gESiK+qlyiGYGU1Z8IAnqJaD985ONHyJch+ldw0V8kEN7iiecxLW
         Y4FgRQFJWzmtYSGpVj0JOMsY+xrl+Wst+PUm0h2Xo3zF5O9t4UQ6QnSoO8bNrTghriqv
         PmUCVKwyhZZLMAaoMgjLDQ4X8U6euFwNE2Oh+HCSMSI2+2xQI22Vv45LMpJWTj1fUon7
         fTnGRGYgpYGDTdv+zaDSiMdfhh81YNXhoSbbKvMLHrETurvsW+jtakMCxD+7KEJs4dLe
         2AMn2xPSi1535ZDJsqP+fGDMxS+oc1gmC09ALLhbIzBrCzNSJiUwKrFbWIe2yZf8IoB9
         NmOA==
X-Gm-Message-State: ANhLgQ2Z+dtEWGFX3w9eVnPezMFgtTHhcKPR5ieuQqOYGVFQbcBS+smf
        FpY3YcLN/4ti0aWWFw6fazwUVSSqLw==
X-Google-Smtp-Source: ADFU+vudp1XNo6n7FBeUcZB1ofc0XRuAME3/cOyJSh2mzNC1En9Bsndamnl/jT4bdJLL0ij+ESqIwA==
X-Received: by 2002:a63:4453:: with SMTP id t19mr6701136pgk.381.1584008408207;
        Thu, 12 Mar 2020 03:20:08 -0700 (PDT)
Received: from athena.bobrowski.net (49.37.70.115.static.exetel.com.au. [115.70.37.49])
        by smtp.gmail.com with ESMTPSA id nh4sm8124459pjb.39.2020.03.12.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:20:07 -0700 (PDT)
Date:   Thu, 12 Mar 2020 21:20:02 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Is ext4_dio_read_iter() broken?
Message-ID: <20200312102002.GA6585@athena.bobrowski.net>
References: <969260.1584004779@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969260.1584004779@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 12, 2020 at 09:19:39AM +0000, David Howells wrote:
> Hi Matthew,
> 
> Is ext4_dio_read_iter() broken?  It calls:
> 
> 	file_accessed(iocb->ki_filp);
> 
> at the end of the function - but surely iocb should be expected to have been
> freed when iocb->ki_complete() was called?
> 
> In my cachefiles rewrite, I'm seeing the attached kasan dump.  The offending
> RIP, ext4_file_read_iter+0x12b is at the above line, where it is trying to
> read iocb->ki_filp.
>
> Here's an excerpt of the relevant bits from my code:
> 
> 	static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
> 	{
> 		struct cachefiles_kiocb *ki =
> 			container_of(iocb, struct cachefiles_kiocb, iocb);
> 		struct fscache_io_request *req = ki->req;
> 	...
> 		fput(ki->iocb.ki_filp);
> 		kfree(ki);
> 		fscache_end_io_operation(req->cookie);
> 	...
> 	}

I'm not exactly sure what you're rewriting, although from this excerpt
the way that this is implemented would sure cause the UAF in
ext4_dio_read_iter().

I don't forsee any issues with calling file_accessed(iocb->ki_filp);
prior to calling into the iomap infrastructure, unless I'm totally
missing something obvious...

/M
