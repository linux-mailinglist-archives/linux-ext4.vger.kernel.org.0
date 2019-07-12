Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1C267620
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 23:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfGLVOH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jul 2019 17:14:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41267 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfGLVOG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jul 2019 17:14:06 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so19209037ioj.8
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2019 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5r+YfOnepDJT24eGQOFoXrocQscr9nVgzuk0/Dd+YoE=;
        b=lkLMriEf4lkHnOy9F9zuD4pp71hmsSNzGWKNlhLiLgV0KRd+9r3R4wm1tDydEb/ol/
         QTUrlvaZp3sHznMH6ITUwMRiqI8X9SFCF4VvcX0sak5U1HC7L0uVdMAtR0kylZeVSGcA
         ME4xrhjdIc3XypIijRxKardgoQGM4yNnBVRjPDYsmnrv34X9mhaoWuMrm9lwLEg9fRlX
         isT4JRzAfZVRh7yb9myE+SbRhfBa6qNw9+f2r51mIARpMRjBYwEjBltU6Mdc+ql3td9I
         5yQOZ1PVgaut2juYvRfFiMBfaEKTDCjRjnv4onkXjSt+cIRvGbFypYseUvgaueo/rBis
         bw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5r+YfOnepDJT24eGQOFoXrocQscr9nVgzuk0/Dd+YoE=;
        b=kiSnLc+ociiG4grYiU1chskGQt8TbReVrEcDGJrtdD9j61WwCq9evXexgebnY3XYxw
         rapgtUuE6hGZj0buPE1RLEf2ZtskwYCvGsb0prReGJUrtmcbSSXjqSkOcWMeCVRSv1q5
         M086saesrFc3sadLAX44PzLNJR4OFPe3oEwDHX3R8TLA9d9ENrgOoZMtwvF1PJZ5NGur
         yYGNUw4lT2qGUmsGzpEJFCVU6YL2C2slcvqKPwIO4BwHFNQkgnAkoB16zXQCEfPAH/pV
         XnooiFt1uPiaxGXYajtLRW+kx++HtyXPG+I4t6ZFPGoiGsTKHOGGy4t/9yK6HKL9MLaL
         KISA==
X-Gm-Message-State: APjAAAXKx1FzO4bxEgBtVXz9hhjB77sjGV2OIF6jYSAigZFFQRzTfezY
        RvJQw+Jp/oy5RrZbN8YiOukwsw==
X-Google-Smtp-Source: APXvYqyoKydjjid6J3QSDHbLmojgk7rAEydbdhHtWSNeAf1mQzg4Ri0IVz1Xf2JzGyx5JMciPbpRYg==
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr12687683iok.144.1562966045592;
        Fri, 12 Jul 2019 14:14:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id s24sm8940492ioc.58.2019.07.12.14.14.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 14:14:04 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:14:02 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Theodore Ts'o <tytso@mit.edu>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 2/2] jbd2: remove jbd2_journal_inode_add_[write|wait]
Message-ID: <20190712211402.GA244046@google.com>
References: <1562914972-97318-1-git-send-email-joseph.qi@linux.alibaba.com>
 <1562914972-97318-2-git-send-email-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562914972-97318-2-git-send-email-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 12, 2019 at 03:02:52PM +0800, Joseph Qi wrote:
> Since ext4/ocfs2 are using jbd2_inode dirty range scoping APIs now,
> jbd2_journal_inode_add_[write|wait] are not used any more, remove them.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

This looks correct to me.  You can add:
Reviewed-by: Ross Zwisler <zwisler@google.com>
