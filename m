Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80FF078A
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfKEVAv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 16:00:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46941 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEVAv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 16:00:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so15504881pfc.13
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2019 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nt3SLKHMKobpRywSNVwbpv8AwQhfDeZr5YI7OOdkAIs=;
        b=e7TrStncNCzsbjR1RNNssue+KRAXg0cIf+2YUOc8a9bEstO6nMlR0nXVb8DH5rnhew
         c+oh7zl7BDiuj3NnLnyyBk9L+v6c1KgTfdlyIAF2Qj8KAgO9fgKD71kzUjm1UkArhE3d
         5Nwkn+NmrxjN20i730wYOW0tmLlrlrMS9SKh7/QMrapKnBqvAcRfdftaaLy8/bC96i4m
         O1CagTJWoBqN8MOOxeZWTmgZtkyizTGcRb3FDAXcrT0SJArMCrwFIeNnFGlZl7LjQuDD
         EAHtqzInMNItmFACYD3oJ5f1sNxXd4KDcjIkHkq9VJ4AGNvUydZiLqqkoTTrVtEiEB5Z
         Mw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nt3SLKHMKobpRywSNVwbpv8AwQhfDeZr5YI7OOdkAIs=;
        b=oFLDloibtkjzkFnyMfILGLbSUCktYdk9xxgQuNg/BzmI7rf7aXfx4gb/ZEoDLWjsx9
         xphnivW3cvbJYp1pVPP+G4akh8C4HHB1rCz3gWsyxt3d05tmI1zqF3b5T59PAWOzin9g
         EpaGrJYO5Nw1iDnOWZiOQjqkCtqe03Z/quUTfmeuKxWAS6gmJN+EGKPWyBVbLoORqqjW
         HTRIQzjrh1doqZoiQ0auVs/bG7W7GZ7W4TDO9PSIsGug+dOH2Rz7svqh6XZBGuE/U6Tz
         dcQ3LfZuNZffmeC2ZGEFcs6ygEC1So4r7q9Xhmres4IWcjnFgbuOk5jjfmI1FF74PDsY
         0jcg==
X-Gm-Message-State: APjAAAUpUC1PQ8UNTggQuIGzyCaNjy9COiSc2Ef9Cag4YErHCrDW/6Q+
        c9/LnRswdE8+lpS/mmm1MDYX
X-Google-Smtp-Source: APXvYqyGSj0xcWMi6VxEtPzU2CuntPx/T6c3hBML1pNsvTHKcE2DnjwtMEgAUCnVxzV8Tk7oczT4EA==
X-Received: by 2002:a62:7c52:: with SMTP id x79mr39555174pfc.18.1572987651049;
        Tue, 05 Nov 2019 13:00:51 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id y11sm24666407pfq.1.2019.11.05.13.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:00:50 -0800 (PST)
Date:   Wed, 6 Nov 2019 08:00:44 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 11/11] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191105210043.GC1739@bobrowski>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
 <20191105135932.GN22379@quack2.suse.cz>
 <20191105203158.GA1739@bobrowski>
 <20191105205303.GA26959@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105205303.GA26959@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 05, 2019 at 03:53:03PM -0500, Theodore Y. Ts'o wrote:
> On Wed, Nov 06, 2019 at 07:32:00AM +1100, Matthew Bobrowski wrote:
> > > Otherwise you would write out and invalidate too much AFAICT - the 'offset'
> > > is position just before we fall back to buffered IO. Otherwise this hunk
> > > looks good to me.
> > 
> > Er, yes. That's right, it should rather be 'err' instead or else we
> > would write/invalidate too much. I actually had this originally, but I
> > must've muddled it up while rewriting this patch on my other computer.
> > 
> > Thanks for picking that up!
> 
> I can fix that up in my tree, unless there are any other changes that
> we need to make.

If you could, that would be super awesome as I don't really see
anything else changing in this series. I'll probably send through some
minor optimisations/refactoring cleanups after this series lands, but
that can come at a later point.

/M
