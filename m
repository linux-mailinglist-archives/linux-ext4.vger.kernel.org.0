Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFF10610F
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2019 06:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfKVFxq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Nov 2019 00:53:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40156 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfKVFxo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Nov 2019 00:53:44 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep1so2579196pjb.7
        for <linux-ext4@vger.kernel.org>; Thu, 21 Nov 2019 21:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xL8yI/1Gr9pFEvF3XN2/mbVw7cvtJ5vGivyK7ET8Uns=;
        b=RA8eqBfd/fPZmuHXu2jsDZqldtL8MY9mZEvq1vN6w2YCCHaUMGPmAuZh2t5joccdkw
         3Kc2fOP7q+HZkwtQS4ZpJiiVVfOK2uqROQkfMyie0083xn9LRG14AjPx1pQ1n8sTylh5
         RSy66JFiyFHGAkYh0rAA8jm9nE2zzTZYDW+jUS8NHt+QNt3mgkteDq44j+Rnq7L6aIzU
         UtkqNbl35UM0vtmiEjKsI8Cyd7o+GdDEI5HLOPWfKYUuzVDDN0ulPYIA+zjGM9UAoAiW
         RMFnYGizpH+DTBHv6bFxcGxreBE27LbbC8xafOjS1moGHJa9xC/oBzaV9P6Aw4qt3HWt
         aDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xL8yI/1Gr9pFEvF3XN2/mbVw7cvtJ5vGivyK7ET8Uns=;
        b=DOKqgACCHqCStd0q6BPkW+8dC0sQjM9UQMI0q3Qdizvd9LRuBm3bBCx4lhz65tAqEO
         eaWkMsxMATp6w4diU7rE93nsvOcMJzQ9fpf0PzvlAfVLlIuNEnTAh5mozY0QJvEXXE47
         U9g1W7d7VzU/i+VPSaZq/XmosMNHfHjp648+1POHUTvqbZIWC7IY3auBSR7iTj7VKeTV
         S/yZAw2pP+bmUnBTfStKMfPb5WHH+uEaOJcH5XcHWh6X7akpdFJ/H4LxCO6gZ6mPey96
         HwPCq/hsnIQe7xJsX/p3As/+S3cI4EOEAa+JK9p4FWPFPlJ2nUd32jfSy09ghVLQV9eI
         1NWw==
X-Gm-Message-State: APjAAAXvYI+azGSOPWrU0gXkiZQLLBK8EOPVx9VihGkwD0NxmPaMRyrX
        rBCClks8xQs+ocu1YREylHDT
X-Google-Smtp-Source: APXvYqwZbS5abHHMUAqp7WPVGUN/CVcIKOOtjnPq0Lyo+S/rC4DvPWY6IWUiB4cYHw+4SBGg2/FO3g==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr11879747plo.159.1574402018641;
        Thu, 21 Nov 2019 21:53:38 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id 13sm5290446pgq.72.2019.11.21.21.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 21:53:38 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:53:32 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 1/4] ext4: fix ext4_dax_read/write inode locking sequence
 for IOCB_NOWAIT
Message-ID: <20191122055330.GA13688@bobrowski>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-2-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120050024.11161-2-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 20, 2019 at 10:30:21AM +0530, Ritesh Harjani wrote:
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our dax read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> This seems to fix AIM7 regression in some scalable filesystems upto ~25%
> in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

This looks OK to me. Feel free to add:

Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

/M
