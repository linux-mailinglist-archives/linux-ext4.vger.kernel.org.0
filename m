Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B556A1A0682
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDGFWU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 01:22:20 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:37936 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGFWT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 01:22:19 -0400
Received: by mail-pf1-f182.google.com with SMTP id c21so269002pfo.5
        for <linux-ext4@vger.kernel.org>; Mon, 06 Apr 2020 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:in-reply-to:references:mime-version:content-id:date
         :message-id;
        bh=2b6/5hDTzERECLz7PqTEgkLnwDsZ+FbAPtHdBq4mVhc=;
        b=vKuQGUlhoLO4sJSKkdUnwodhK3ooAGMO44BAPKwyLhi/HBVG9xvosRdgP45WqCROXA
         E0PlpEySC79lEjAci0enuKEpCyxIca2hrPwPgZmBlXHHoEKwYjs8UQZuU+mmCxLdkYhb
         O5CkCYDrQtQ5DMdSWTQXaEDm78CBFj+2LE83llklUZNNNIwK5fjhEG3kxvG36KT+ul7z
         1BGGALYovX11DnhL+Y/I0Y2b4ShbnyHJ+cYJhmDLP/3vxTlp1wgrdLxnIruzSwgCkbW4
         NKSr3HNvsOI+sjHa6NyDkY2hbzftrnMFEUJtVGfuAg1f+pejmVY1ulet7prNtVdO5AyB
         8sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:in-reply-to:references
         :mime-version:content-id:date:message-id;
        bh=2b6/5hDTzERECLz7PqTEgkLnwDsZ+FbAPtHdBq4mVhc=;
        b=HQ74F1oqf9PhCGeYZCaHX5w6jb6JIoY8jWxD2v0wUfmwKhtAWw6Iv52nZb1ig/KLH1
         vdabQ317AJFAEyiLizLp0mV1HGgwfN5VOBYXqEuWBZaoNyYS4RHe6CMPxHWJWaOm68hV
         n8vUAglguCqxLEL6wuR4/tO5qzQrNDmwNxMN6hNe2el3QoKCzEiFyCHw/WRg6kDq9drq
         44R1mNDsjGwt0cIrR+LPbLy7rfJxZsf8frnFq+Jt1HwTiskWrdgQy7GsuY/v9W5kgx+t
         FIBW22/nRGQ27zAHX1lmGDAvrebtU1pd1v1TFI4uQ7ztTAEpEH7tvQC0sce95orTo9aZ
         2hFw==
X-Gm-Message-State: AGi0PubkvHPzFAanUdCKfoDoXH4Nlty8c5tMNfAslm3/Fh0hTgJihf6K
        2Gu1+uuc/CBIqybFo5I+mn6if5Uk
X-Google-Smtp-Source: APiQypLjK4VXweEbl44binr7XfFwuassbjmuyvHbjNZHDC1A9RwdREjUB+gfewf4ocxIE4EwzhMR2Q==
X-Received: by 2002:a65:4249:: with SMTP id d9mr354527pgq.198.1586236938284;
        Mon, 06 Apr 2020 22:22:18 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id h64sm12718308pfg.191.2020.04.06.22.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 22:22:17 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1jLggi-0004db-K1 ; Tue, 07 Apr 2020 14:22:16 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under xattr_sem
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
In-Reply-To: <21323.1586173821@jrobl>
References: <20200225120803.7901-1-jack@suse.cz> <30602.1586151377@jrobl> <20200406102148.GC1143@quack2.suse.cz> <21323.1586173821@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17829.1586236936.1@jrobl>
Date:   Tue, 07 Apr 2020 14:22:16 +0900
Message-ID: <17830.1586236936@jrobl>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> I will post "the fix passed my local stress test" tomorrow.

I did my long stress test many times.
And the fix passed my local stress test.

Thank you
J. R. Okajima
