Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51A0E301E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2019 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408108AbfJXLRd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Oct 2019 07:17:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408056AbfJXLRc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Oct 2019 07:17:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id l3so589615pgr.8
        for <linux-ext4@vger.kernel.org>; Thu, 24 Oct 2019 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=72mt0Fv0fF6HgXRK9YSk0V4Lu1RdSxFd5Ezo9zx916M=;
        b=nbUaHNVYOKa4Ozpo/wZGITDCOOlXu1wZOm1JtnF/TAbcX++qCWman5DVWlCSzdsfrx
         SlN0VwE19W7nbfkFJZ/49ZU/maU3SYsUUzWW1Fkd/iwPtnFyNSlh3jZv3hkNdkL/7/rH
         /67gc47D5VoL9rY1mHcRg+/LX8VKQWeB131YlB0H4QdOKAJ7RlRg3vJRwmh47XtfWBB2
         hulbfKG59X4qUd0GbsMQGgXqRqmlMkByW1vCoj/ojnMDwiJyNC/8GbWRj7bq7WitRloG
         hbdxj2ERxzTAl3RLiXBt7fvPNUMAG8tAK884jd9x/SPpK8L3aVvAYVe4NTvqlSkMu7V5
         3ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=72mt0Fv0fF6HgXRK9YSk0V4Lu1RdSxFd5Ezo9zx916M=;
        b=TQynZK7pVhF1E7odfYeWJzDOK92cYArMYO1vWgw1LrQ2OSnBifLzDDEIAQsfee5DmJ
         MbbvnentbqjbguVktQKeTWuLweVfjlXPwhaO/MliN5JfzxdM/vyhUzBJqYR5x2lb+hA8
         b5WdrrjYEeVvd7V371rKjXZsbWN39Cj4q0WRrhJOmsck9MIxUOePO9tBDfHdYb1clzCu
         sLLIcxURCOQoH98Y7Wn1D8hgQv7ksD03Zz3W1MWPP2MFZDsVY08qlS9i4+3UfMaNnQgb
         e3AyRtCGEQgFb8P5cjKrqHBszIZxVrEmRsrRmEHscIooF+Av92tQ0fTbh0sjn/2fB9ox
         UJig==
X-Gm-Message-State: APjAAAUw6IeSDvSzFxQTfMpQFtjllMyPh4VOzO548A0Ehn3KBoe+Grmo
        PIJytWLOfCtfQ27+++A8AZT+
X-Google-Smtp-Source: APXvYqwjjKMkNaCR0cMMf3F7jxyXQWvOsJkgfIGuhcoVFFEw6gq79y7Ew5nFcCje6H0+zIZ8iF13Qg==
X-Received: by 2002:a62:b504:: with SMTP id y4mr16904529pfe.198.1571915851899;
        Thu, 24 Oct 2019 04:17:31 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id y80sm27463586pfc.30.2019.10.24.04.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:17:31 -0700 (PDT)
Date:   Thu, 24 Oct 2019 22:17:25 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 05/12] iomap: Allow forcing of waiting for running DIO
 in iomap_dio_rw()
Message-ID: <20191024111725.GB20373@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <5dc3085af89a3e7c20db22e9e7012b4676b440a9.1571647179.git.mbobrowski@mbobrowski.org>
 <20191024014153.GA14940@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024014153.GA14940@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 06:41:53PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 21, 2019 at 08:18:18PM +1100, mbobrowski@mbobrowski.org wrote:
> > This patch has already been posted through by Jan, but I've just
> > included it within this patch series to mark that it's a clear
> > dependency.
> 
> You probably want to resend the next iteration against the
> iomap-for-next branch, which includes this plus an iomap_begin
> API change.  Darrick plans to have it as a stable branch, so that it can
> also be pulled into the ext4 tree.

OK, noted! Checking out and rebasing. :)

--<M>--
