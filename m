Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D18140EDA
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 17:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAQQWE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 11:22:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45700 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgAQQWE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 11:22:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so11880813pgk.12
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jan 2020 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/QRDv8e8iQEqDNCGkiiDK4fWPlSZEWb6aUg/XWFLNs=;
        b=DZers6f/bW85HgG9w6xwZ2W7ctE6cirUkp9BOXc4wzAQLJ8hbclatauI3Jbj0CHoK3
         raCk5YguGXY7ntXQRwWygDUTHFX/ZCxFHtLg4MqKOtAOzrmkgYDKukHBZdsdmmARTe9Z
         fnLvAzVpSyJ56zmYkFOTG/DAmSwYrs/z+jBQ1/D2HMxFlX1/xxY0ZLvqOLtGkZa+yjv2
         JKxSQ/w95eNIT6dgTUPizuLLgOKUIoJJnsLDEbahCyq0yKkwKH2o00mJJYXQ+FJr72DS
         G9izbKZMiUcKxaJ7+RA2zelE0AAv5k9TLUCWR8l0KG815UdhT9gTDuB7xezO08fHmJwl
         YLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/QRDv8e8iQEqDNCGkiiDK4fWPlSZEWb6aUg/XWFLNs=;
        b=tZ072OZasdYreM0HHA1AEjMm08XHFiVZa+aqnSPx7cdNPSewF5kIBxVuaE9XOTRbEW
         myQOtlqo+99p0BmpJwIFCiPaCzAfBsohZ3FBr2QmVqLLtsThRg4FGnEDaDj1sfHbVA2i
         XEuco6+Pj/BcDZ+W6f3kf26xQzKrrOyHz9t1Pj/WfTFdQVASi2Y+XGv6hJyfmEOhPmv1
         whYVStGJWMQm6dbS2GBJP32wCtEDbnABLR47lCFGLeISYiPk8ljEJ/iL/gQ/3jNhlDZX
         uoNIuc5qT3uRhohsVyNt4E4eUSknxFL+HOC/SmmsqHxdPfUEz8o7RGuNvZxFkVArhx6A
         5+Uw==
X-Gm-Message-State: APjAAAVkMcH/NldXDwoRBPZNe+i/UBz8kHPzO4uivHsKdkLo7IMpPZ0p
        nKzPs1Bucu8cBglBfCJnm7F9NQ==
X-Google-Smtp-Source: APXvYqwcs87BORO66K1Fb2Q4UZMx1Tbzz2nRXGK4re5uWiRJWWTgWw8OWfntW6QesxVSMp+PIgbbIQ==
X-Received: by 2002:a63:d00f:: with SMTP id z15mr45867227pgf.143.1579278123365;
        Fri, 17 Jan 2020 08:22:03 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b128sm28618425pga.43.2020.01.17.08.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:22:02 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:22:01 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Colin Walters <walters@verbum.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, josef@toxicpanda.com,
        dsterba@suse.com, linux-ext4 <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
Message-ID: <20200117162201.GA282012@vader>
References: <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com>
 <20200114170250.GA8904@ZenIV.linux.org.uk>
 <3326.1579019665@warthog.procyon.org.uk>
 <9351.1579025170@warthog.procyon.org.uk>
 <359591.1579261375@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359591.1579261375@warthog.procyon.org.uk>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 17, 2020 at 11:42:55AM +0000, David Howells wrote:
> Hi Omar,
> 
> Do you still have your AT_REPLACE patches?  You said that you'd post a v4
> series, though I don't see it.  I could make use of such a feature in
> cachefiles inside the kernel.  For my original question, see:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> 
> And do you have ext4 support for it?

Hi,

Yes I still have those patches lying around and I'd be happy to dust
them off and resend them. I don't have ext4 support. I'd be willing to
take a stab at ext4 once Al is happy with the VFS part unless someone
more familiar with ext4 wants to contribute that support.

Thanks for reviving interesting in this!
