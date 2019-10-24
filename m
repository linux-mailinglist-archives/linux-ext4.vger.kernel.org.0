Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29F3E2FFE
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2019 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407761AbfJXLJv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Oct 2019 07:09:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405174AbfJXLJv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Oct 2019 07:09:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so14959147pfa.1
        for <linux-ext4@vger.kernel.org>; Thu, 24 Oct 2019 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXMIvt4F5UQWhocwG3x7DljABtbodjF9dsK9HxbUrhE=;
        b=b52ptdiYIBzdpXnd0cLtjuwkqx+WVS8iES64Lp6Jj2aCTh3h5auYnIQknBADSLYgrn
         URqRzIRtZEolFzmZtIiwSPjnFDV+X6xtUkBJfTorehAp3eEqYpcKtFk3qLg8lDmxeE8+
         OKQsTzzfC/ahQlL67r8r4Pprp4DQEQFZo0+wbX8QDpK+ivwe5B978CBhMrpZHkIZisP3
         M6Hb79sg4m8YWWZ12DPdsvkHDEvSfsGphKy455TpBnpvDAD/GoRjQQb3a6IFKHRuHyRK
         4a8AVk8IL0+9kRunaIbIi9dey3hu1OXBJ8YkgndPCUcAnJsdho3tIJ39FQYb7AAYQI0U
         hWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXMIvt4F5UQWhocwG3x7DljABtbodjF9dsK9HxbUrhE=;
        b=cED/k4cSYxI+/H8X7/Wy30fo8qKMOrh6B20duZPgCuWr1IjcOJSNZVYkcAupeLGLuR
         tQUp1L17ZJWNhdybGudHRUc5h8/O4hALUdAY9cmr7HbGU6Wf8CBf/81inO9NDuw85i1F
         OE+KxzuXJSJ5NpSNBwKZEYQ13iK+mp+SUpmbZmP/Ma/qOtSgQN/Y+6W4Cilhzms6+voT
         qATts+YmMjcBWs1sI/lJeRWVpjCr8qRKixejQF9/8qHdvFrziZtaKLCPEHEWcQRtJsu9
         Vg9eYU925DdQ9xMYnWMHqZIS1ENV/hr09V9hIfGjBONZJJGDRBOS/Ts3m3J084ltNI+l
         CyTQ==
X-Gm-Message-State: APjAAAVGs9G3LhIAI2mhshUvTB6JJ/npq1oaGNXoP6DRVdC51C8VT55F
        00TIgntgsXpDSidNSzUGYiHL
X-Google-Smtp-Source: APXvYqzDenz4oBjvbU4XFxqC5JO0mT2cTkfQmvuFNs27jpST1pFkpWE8rDyRC321BktUZjYb1F5qIA==
X-Received: by 2002:a63:d1:: with SMTP id 200mr15916693pga.108.1571915390090;
        Thu, 24 Oct 2019 04:09:50 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id z2sm1916765pgo.13.2019.10.24.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:09:47 -0700 (PDT)
Date:   Thu, 24 Oct 2019 22:09:41 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191024110941.GA20373@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
 <20191021194330.GJ25184@quack2.suse.cz>
 <20191023023519.GA16505@bobrowski>
 <20191023100153.GB22307@quack2.suse.cz>
 <20191023101138.GA6725@bobrowski>
 <20191024015857.GB14940@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024015857.GB14940@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 06:58:57PM -0700, Christoph Hellwig wrote:
> Maybe something like the version below which declutter the thing a bit?

Yeah, I like this suggestion Christoph. Super awesome.

Thank you!

--<M>--
