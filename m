Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4465516B41
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2019 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEGTYp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 May 2019 15:24:45 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45671 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfEGTYp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 May 2019 15:24:45 -0400
Received: by mail-lf1-f50.google.com with SMTP id n22so5156735lfe.12
        for <linux-ext4@vger.kernel.org>; Tue, 07 May 2019 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VH2cI54WOtf0TgOVICv7YfH/dmJx9RgBuqx8oc1Mjk=;
        b=F6ld+tZIKD1TRL0AE6fEb2WqRxcP76uZx0RNPDleIxyf5RJkwYPqK0Bs9zD4aODmmE
         4NNavp1nVKPc4olfZNB0csbl8Mt2jrfw/4cvqI1dQpb6hDyRxWSjJ7Yy4Q29HBvFbOfA
         JtYubFLJeY+4ZpX9T0ONIWuycTh2DIrMPc1SCGpQzEDby6c9B7ZikuGkc84pDR1T+N6M
         9spwBfJp4nacEIzecHYOyudxpJIHO5m/IUkW4JFPQf66ZbDiyfZVU/nw8vjKyLhqtWer
         9FWQL1ENLRVadfjFY2rI1CERtp+W1p4k6aV0bmDTRupY82fFnsyC2IcEpAqT8PcIv623
         jo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VH2cI54WOtf0TgOVICv7YfH/dmJx9RgBuqx8oc1Mjk=;
        b=LA8DAwqsm+3JXspBNt9nrlzbOnGQtYQhesFBG0n23bDJS4nC9Evl/qkwDVab13iAPr
         TuJpXIYIHOGTVUrCebpiU9pKjdjaLFxWRrpONXFs/cqV9p0DKZnAUQ5PK/D2iYeVTPcI
         kHh6AVEYU9q6lPrXkhp8XPKFrI5TkrvOOwqO6YGx9ycCRUhWQnoMKxw/BxXurNGHwWCQ
         y1q+GHAmpn7gM919io7hCn/fnpnTf9rVPrj8iQTcAtr1OAXAQ6zZF5fu1ojdKzy1E4yn
         XjnNNcfzWuOSk3mPZ4gcuyXWm6Jq2z7oqSvZxwGT3ZfVH9j3kgc8H/AG9yJO8Uq/lZ44
         tEvg==
X-Gm-Message-State: APjAAAXjlqJOGo7IrwjPlqs79AWK5dkolmWbw2JfZgyud2gF3IN75aWY
        WsJU7WBzEkmJaSCBxy8fvp/CcRU266Nku5mELLy0eg==
X-Google-Smtp-Source: APXvYqyg8BJ0mWtUnVsZIHd1nlxtEq/TQoby+zEdt5YK0v6BrfynU4C4tehxKhziDkaheD+CcYQOn+z9h45ZgO05JFs=
X-Received: by 2002:ac2:51a9:: with SMTP id f9mr9455271lfk.56.1557257083907;
 Tue, 07 May 2019 12:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com> <20190426050039.17460-5-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-5-pagupta@redhat.com>
From:   =?UTF-8?Q?Jakub_Staro=C5=84?= <jstaron@google.com>
Date:   Tue, 7 May 2019 12:24:32 -0700
Message-ID: <CA+nGSuOgCAoS4MkbuSL2q5Gyi4jG2oyJqLu_sDgexm5fSBmPLQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/6] dax: check synchronous mapping is supported
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, mst@redhat.com,
        jasowang@redhat.com, david@fromorbit.com, lcapitulino@redhat.com,
        adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com,
        dave.jiang@intel.com, darrick.wong@oracle.com,
        vishal.l.verma@intel.com, david@redhat.com, willy@infradead.org,
        hch@infradead.org, jmoyer@redhat.com, nilal@redhat.com,
        lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com,
        yuval.shaia@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, kwolf@redhat.com, tytso@mit.edu,
        xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net,
        imammedo@redhat.com, Stephen Barber <smbarber@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Pankaj Gupta <pagupta@redhat.com>
Date: Thu, Apr 25, 2019 at 10:00 PM

> +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> +                               struct dax_device *dax_dev)
> +{
> +       return !(vma->flags & VM_SYNC);
> +}

Shouldn't it be rather `return !(vma->vm_flags & VM_SYNC);`? There is
no field named `flags` in `struct vm_area_struct`.

Thank you,
Jakub
