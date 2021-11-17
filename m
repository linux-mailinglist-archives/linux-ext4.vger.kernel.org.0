Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A4F454C51
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhKQRrA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 12:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhKQRq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Nov 2021 12:46:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A2C061570
        for <linux-ext4@vger.kernel.org>; Wed, 17 Nov 2021 09:44:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so5865391pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 17 Nov 2021 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
        b=Pv9ANnOgMM3OWe87npnRfFAHy06jY7erPMdRcRc3VaKoizlrQvir6ceQnBEYeLyHYq
         r090jiPNw0sW2/Hep475ohjoYTOQRdpvhHcth1Xy44B2FrZqXQwnGcHV2wnXbXiiNy2O
         MDFnhNTzB1g4/CDk+YjqQXYVRalwhzm8GBHuQpfxBToXDBsfgLgdgSQoTQw5N7NkHGFW
         TO5GeE55hpjrU15s7LrDdGRZzL745vjZFcejg91qo0BT5VlwUF4cAT1X4T2RsJHhvJDD
         yt9A6syUQNrss5NuJD0lDiesCY4CCjNhydNUyUTp9hI7U9JLuZ9oCU9X4sETOzbxu27f
         +aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
        b=CDmI1pPH2hlIFQazb+6BHbFVCFv58E8gAR/nNcXhYmwrPWVdXPr3Kd3WrHdB+PX9go
         VvK85bvB9Njv+6UX5DbLj2Re3ndY4W5VP+XnYZRW0rqymWwcdB3s9BIy9eLIaX+XGOUf
         oVY2rlTKSkn5BCX4KZ6R3VmwFbxz3jhMk8qccC4PUopSj6AVlx098bI1TYkwOVWKoFTi
         Q6sTmY7Kuq6zVmWiwt/XAPiYp9DlqR287AMECc3JDkz44EwwsLWSHRUc69hKmBFnWIDM
         FDbmJuisIMZo1BbXM6pHLvhFQj5vP2b+Xof6zUq08cZcI+LitEtIA0/0aP51bbdjW7mg
         w40w==
X-Gm-Message-State: AOAM533iH4Bc+I39YBvVQjwVkE7CPlI7R+7j56WvOzn2tLK53H2voagK
        1zn6ecAUuZQ/sJDKNTUj0TiU11xQJMJwLlM+9uMtfQ==
X-Google-Smtp-Source: ABdhPJzkkUh8z9sNK4035DW8QI/H+P4iSKXjlSdI0PBBNtw2VKYOtUcKXKOrARUi3RsvsZHwUrgnG1t18LSvWsJCfmc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr57313687plt.89.1637171039968; Wed, 17
 Nov 2021 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-4-hch@lst.de>
In-Reply-To: <20211109083309.584081-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Nov 2021 09:43:46 -0800
Message-ID: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
Subject: Re: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Applied.
