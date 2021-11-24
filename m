Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF045B2D9
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 04:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhKXDye (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 22:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhKXDyd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 22:54:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B3C061714
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 19:51:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u17so738547plg.9
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 19:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJJrE2V7YDKia68Ncdl0fsAelSVdGw1v9JUEXR7xY5Y=;
        b=vNWAOXzyAyZLL55qsyuCit1K8cMla9Q+I7a8HbLHArMfgpXCYh1wtjdFnUFWSDzn1/
         T1Hm88FkQaWO7xTh0mJLeCLeygQ9XisaZ/XdmwUyLak3fa4OobGb1BWM5ZwyXtbfybYZ
         AImH8X7vgDZd94f4gGyAHjFhglD+WoYohpNRn3ZnIE+uI745TpScjyc77ErLiPREiHK9
         9zQlfvf5/9sPOSgOLuvsV+WpFV/QM4YFfAdVMzyOtae7ikCAA2NGiOEOPGZF9XEqRun2
         JjRU5WwiL+LDDdZvrMhOHyatQOMmuQaQU9bgUORS8BfRoMg++/EVDk/zAuYjdunbyyUb
         o34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJJrE2V7YDKia68Ncdl0fsAelSVdGw1v9JUEXR7xY5Y=;
        b=rgLAvFraytxvaozIjSoJ9tZ79u9Q+Pbllmr7rs/Olo+7HT9T3Oz0GGss+Wa0+nZx95
         kh3dL4un+2X+U32lhj+64Aog4YSJjypJFYA5dSk6WRSxDNMLfGkoV3Nson/d19Qk0Ke1
         W8DgwC7h9nFKcWY8qop1tsO5AdJJ10hjNnJVKxjzFy+NTli/M7P2kEZQOnujT/vbO/ux
         li8WHpK8leON9WzdhYwxB+FpYMEx90RBhyX9ohCnQP0lHEXux8gZbPX1yPAdx6dV/aOz
         6MFM5ttN9RSxV82fvJxpiph1GhHrZykuJLJvQJo3OXc/Ft2QifDDkFzTiXF7vrrbX8L8
         Eu/w==
X-Gm-Message-State: AOAM532AGDjSgqex7EDl81W6En6f4Iylz2IpNYnZdYtKPb+gSFMucJM2
        /jHLuRxuLi/QkL44r2LXIhtoLJbxqHvsXXL6Fz5K/g==
X-Google-Smtp-Source: ABdhPJzAHmbz7abbV3IfUPlG+M3Adum2An1EImXm+0nyzeG+6b50syE8SI9jQ3gftFqA5yglDnQ0v4N9/X3Fjpc01Ms=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr4029053pjb.93.1637725884625;
 Tue, 23 Nov 2021 19:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-29-hch@lst.de>
In-Reply-To: <20211109083309.584081-29-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:51:14 -0800
Message-ID: <CAPcyv4iV+PTdvV+Tq5j3nR6UWFQPTeuzQrZGdS24HdVehY_OaA@mail.gmail.com>
Subject: Re: [PATCH 28/29] iomap: build the block based code conditionally
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
> that is always the case, but it will change soon.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
