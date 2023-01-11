Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072D5666515
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAKUww (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 15:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjAKUwr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 15:52:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE93E0C0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 12:52:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso16812376pjl.2
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 12:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkqhoeCZuwa+2bEMUhxCOdyrJETsu5EtKMG81jKmyM4=;
        b=ie0gHeNUjoqz2jvtZmldqUXtiL0DZ/4lwcY++B/0ysqxzJJczfN176RleYjOTd4hNt
         viBv7vyljweJKDNXDo8V+QO58QjYsXICTF7GJ3cO1iWDt8GCHwEhu6XCirIIS732o/HZ
         PJh2O/V+0aPaxqTz6OkWPWLYJDrvRgPSbI5YK0s3cbmeHQTNn0uBrO990NddYB1nYTKH
         cL2F6FJ/HhUs0DHrdDTQ5IodOt0T2WgBCLkUyco0njpGj0IWoALnmTYM3itpvVkv+k9x
         PZBXNpWZNsE2kdlfxofFohEo0g6Y9gI2/055tReBc/ragvY+kVbl5P6W4YXvvXyy2qa1
         3DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkqhoeCZuwa+2bEMUhxCOdyrJETsu5EtKMG81jKmyM4=;
        b=3S18PqsYlcRjHaxniSw84zmhMnHAi32zXF0bJrFqAeuAJEE+ALzJfoO2fIDcur/Xhu
         jbeesJnH0mg/QqGvpBY7AUGbSS5K0cyM18HV0y4p1E/rI8Lw9keMrf36otP38x9uHd7I
         3zjN2kbVXd+iOeT+VQXXQb9GyhUlwzFpnqxbrrKMSDfly7DK9K1nB0ziXLfwJwvTZAnr
         83Ks23ZNOx6UPLnL+oljsJutLrxcJgHJ50VbCH8xEPGqBpNeAwndVpR5NuHew8H1tueZ
         DRbTm5zrcfds7I+Lbpg11Qc1KHezOyEBvRu1ytLKda2lSoJVmwIIFvH/1xhf5xoJSX+a
         J2wA==
X-Gm-Message-State: AFqh2kp1Fx4u/z0k632YwmaQPW6MrmYzhqyxp/Kd8FU5DMi4bbaQvGfD
        954guGt9109BUyo+Do/cqOOVmQ==
X-Google-Smtp-Source: AMrXdXvgN3R619MlFxvZvgNlbNpdfvMY7I+Ko6fk0fK9VdXQkV2T920mtD/TBJG8wFVTjldQGALEWg==
X-Received: by 2002:a17:902:ce02:b0:18f:a5b6:54f9 with SMTP id k2-20020a170902ce0200b0018fa5b654f9mr80454345plg.11.1673470365866;
        Wed, 11 Jan 2023 12:52:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709027fc200b00192f9991e51sm10459441plb.251.2023.01.11.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:52:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pFi5R-001vGU-0W; Thu, 12 Jan 2023 07:52:41 +1100
Date:   Thu, 12 Jan 2023 07:52:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <20230111205241.GA360264@dread.disaster.area>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y72DK9XuaJfN+ecj@infradead.org>
 <Y78PunroeYbv2qgH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y78PunroeYbv2qgH@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 11, 2023 at 07:36:26PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 10, 2023 at 07:24:27AM -0800, Christoph Hellwig wrote:
> > On Tue, Jan 10, 2023 at 01:34:16PM +0000, Matthew Wilcox wrote:
> > > > Exactly.  And as I already pointed out in reply to Dave's original
> > > > patch what we really should be doing is returning an ERR_PTR from
> > > > __filemap_get_folio instead of reverse-engineering the expected
> > > > error code.
> > > 
> > > Ouch, we have a nasty problem.
> > > 
> > > If somebody passes FGP_ENTRY, we can return a shadow entry.  And the
> > > encodings for shadow entries overlap with the encodings for ERR_PTR,
> > > meaning that some shadow entries will look like errors.  The way I
> > > solved this in the XArray code is by shifting the error values by
> > > two bits and encoding errors as XA_ERROR(-ENOMEM) (for example).
> > > 
> > > I don't _object_ to introducing XA_ERROR() / xa_err() into the VFS,
> > > but so far we haven't, and I'd like to make that decision intentionally.
> > 
> > So what would be an alternative way to tell the callers why no folio
> > was found instead of trying to reverse engineer that?  Return an errno
> > and the folio by reference?  The would work, but the calling conventions
> > would be awful.
> 
> Agreed.  How about an xa_filemap_get_folio()?
> 
> (there are a number of things to fix here; haven't decided if XA_ERROR
> should return void *, or whether i should use a separate 'entry' and
> 'folio' until I know the entry is actually a folio ...)

That's awful. Exposing internal implementation details in the API
that is supposed to abstract away the internal implementation
details from users doesn't seem like a great idea to me.

Exactly what are we trying to fix here?  Do we really need to punch
a hole through the abstraction layers like this just to remove half
a dozen lines of -slow path- context specific error handling from a
single caller?

If there's half a dozen cases that need this sort of handling, then
maybe it's the right thing to do. But for a single calling context
that only needs to add a null return check in one specific case?
There's absolutely no need to make generic infrastructure violate
layering abstractions to handle that...

-Dave.

-- 
Dave Chinner
david@fromorbit.com
