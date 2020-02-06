Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA23154821
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBFPcO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 10:32:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727358AbgBFPcO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 10:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581003133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JkkJGmIOTY9azTSJOAyBmE/D2+0ai1ViZFBb2hElwXY=;
        b=RXFilHkL0l4CdO/k9Iutj05OWHrxZUSNyC/IzGraARKo1KSIg/sJ0t/PhYzpcbJ9Tg2tDH
        EjErpkDonCg6mzManGLDIO957sHEuWmaoEUz3s8R/3HJ1t3hTEH0xkrGTm7jPyw4ApJC+J
        D+awNsE/TVeI6eJnyApHShjVz8afQFw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-wsCx9fyWMA6ccKMHl2Nu-g-1; Thu, 06 Feb 2020 10:32:11 -0500
X-MC-Unique: wsCx9fyWMA6ccKMHl2Nu-g-1
Received: by mail-oi1-f197.google.com with SMTP id o5so2992435oif.9
        for <linux-ext4@vger.kernel.org>; Thu, 06 Feb 2020 07:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkkJGmIOTY9azTSJOAyBmE/D2+0ai1ViZFBb2hElwXY=;
        b=ZjZZNj/dhYikcnPcwYBdl245NEtVbzxJoUOUJLEAwbPBP6zomSmKr6IOXCR97X/JdD
         nAt4O1kfGvD4oT10NTKOlgbvRjYQkXjSJd8Ipn+MIFcj5QowYq4pC8y3xlh1Z62TGEw+
         hd9xtl5/HpW4TtSJvu5b2c0Cea9lbU0om9y7r/Rak3Cf1tELuAdSUeXt4d2qiylh2kJU
         S8BbrEFBPz7vFHdUorgUr8x+wUuCx7mFLj8PahgH26+gVAqhxDZ19l+NLp/2HuUgasx1
         dkfXzXUqPmH3E1iaW1NVyVfQWgWXWQl/7OQIs9vinO8wb/+mZDdxhlCskg9QFhD/8+at
         DCiA==
X-Gm-Message-State: APjAAAUO8HN0nIrkl358Q50ZAyxfeEW3q6k9JB9o8KMo1D90778wMyPr
        BVS+t1Fq6q4OHd9MoBtvtgbRBFRogpZ9DvKAZiP+gaLd7lp8EcEhbNafqLkxrvfH80FB0Q6Q8m4
        6byVpZNUdQixewDRVPqxJcYDffU3zSZcS/Djb4Q==
X-Received: by 2002:aca:48d0:: with SMTP id v199mr7121520oia.10.1581003130622;
        Thu, 06 Feb 2020 07:32:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqz63b3BCvjFz9bZiKofXwlA69pEYM2GvuAIssv4co0has6j21zg9p8DSROFpl+t1g3/AiFAiFF1ObcmOqpV8Jw=
X-Received: by 2002:aca:48d0:: with SMTP id v199mr7121485oia.10.1581003130363;
 Thu, 06 Feb 2020 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-6-hch@lst.de>
In-Reply-To: <20200114161225.309792-6-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 6 Feb 2020 16:31:58 +0100
Message-ID: <CAHc6FU45m59PjBWWO=F740_jyOtKSwc__XfYhP84WkpK0uqcWQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 05/12] gfs2: fix O_SYNC write handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Christoph,

thanks for this patch, and sorry for taking so long to react.

On Tue, Jan 14, 2020 at 5:54 PM Christoph Hellwig <hch@lst.de> wrote:
> Don't ignore the return value from generic_write_sync for the direct to
> buffered I/O callback case when written is non-zero.  Also don't bother
> to call generic_write_sync for the pure direct I/O case, as iomap_dio_rw
> already takes care of that.

I like the idea, but the patch as is doesn't quite work: iomap_dio_rw
already bumps iocb->ki_pos, so we end up with the wrong value by
adding the (direct + buffered) write size again.
We'd probably also be better served by replacing
filemap_write_and_wait_range with generic_write_sync + IOCB_DSYNC in
the buffered fallback case. I'll send an update that you'll hopefully
like.

Andreas

