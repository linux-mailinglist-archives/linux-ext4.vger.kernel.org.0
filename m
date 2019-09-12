Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F78B0B51
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2019 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfILJ0W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Sep 2019 05:26:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35961 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfILJ0W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Sep 2019 05:26:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id j191so2620840pgd.3
        for <linux-ext4@vger.kernel.org>; Thu, 12 Sep 2019 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dt0j6/Dbs+dwW1SIPthaW+qziOAlFsuqXt20b4c12nE=;
        b=12hCQat9jUcgSa47++/HQI/Kl7LxMpOdcs5vqzMW95pKZMUHEhyw9ZMTKknS+6Z2Rx
         K9qJNKmsGVjwgxprs5gDVl8K+aUT2VnsLU60nF0AzZqv5zXtsCwN++iPfEVHgWC+J7j+
         dzo27W3kuN+k10OHxZQp4JFaIL0RYtJn0rAoEKVV3Tjp/yso+xeP3PIyvRGhxb2KSfST
         ffoFGuMIjtreThdQ+W41KGD+0jkLetWQM+B1FTVLAr6v++nXXRuC0Pw6a6KKqO9IL1Es
         KlgfJcVrWGFzhtJHgrA+FEtA/80mCRFIS7z+ma8tpq3q4vca8MZ/qHfHgMp7DzPy84Ad
         FAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dt0j6/Dbs+dwW1SIPthaW+qziOAlFsuqXt20b4c12nE=;
        b=Yj9PlCpRfXGHejzzpmO3EIhUV6q0GwrwU99VJs6EKcA2zHJg73Zr4J75yvtq3LIahq
         L7eMxqty00fgObjRLNZj0aE1NZhfiHH1z+1oeSh0inGmrSsHa9+TqTkw23GgXPa36MMo
         llGyNS7P3p02lCyFLL327/llcjiSnrTEJ+TdtW9Evx4HGZVZHqNp/tGz3i2v4wUYGEto
         64+tM55OxC2zcKl54DeQNzisaoVGgbcrm7qSEUc1ZONLhkT61OhMwoZQ646r+Kg35p4+
         SEZBZks7s7P+7ZtrwxcdactbciR17RgmUlvM9/gvQlk107c7/nxkn4Hsd3uzomKWyZBe
         BgCw==
X-Gm-Message-State: APjAAAVR77KRwVkGT2XV+3caLgoea7g6XmTHDj95QsuOXPrvA7VRtXvB
        m67Sd1eXYXz6AsWlGdKiNmLD
X-Google-Smtp-Source: APXvYqwyIDlF1caDTpNVqUKoLG7l8JslVWsCl4azAP5rgYV6Wp1tuclPnO2lsBQan2QfColr2D8A2g==
X-Received: by 2002:a63:211c:: with SMTP id h28mr36886434pgh.438.1568280381146;
        Thu, 12 Sep 2019 02:26:21 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id c62sm29491396pfa.92.2019.09.12.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 02:26:20 -0700 (PDT)
Date:   Thu, 12 Sep 2019 19:26:14 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, hch@infradead.org, andres@anarazel.de,
        david@fromorbit.com, linux-f2fs-devel@lists.sourceforge.net,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 2/3] ext4: fix inode rwsem regression
Message-ID: <20190912092614.GB9747@bobrowski>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-3-rgoldwyn@suse.de>
 <20190912085236.7C51642042@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912085236.7C51642042@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 12, 2019 at 02:22:35PM +0530, Ritesh Harjani wrote:
> cc'd Matthew as well.
> 
> > This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> > Apparently our current rwsem code doesn't like doing the trylock, then
> > lock for real scheme.  So change our read/write methods to just do the
> > trylock for the RWF_NOWAIT case.
> > 
> > Fixes: 728fbc0e10b7 ("ext4: nowait aio support")
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This patch will conflict with recent iomap patch series.
> So if this is getting queued up before, so iomap patch series will
> need to rebase and factor these changes in the new APIs.

Noted. I've been keeping my eye on this thread, so I'm aware of this.

--<M>--
