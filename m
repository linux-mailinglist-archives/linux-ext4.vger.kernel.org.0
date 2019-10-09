Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02B6D0D00
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIKno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 06:43:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfJIKno (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 06:43:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so1351410pfn.11
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=buLwW9Upwu/0aO+lI2LypZ3xpXUVlEG3VMhVw7VQ4tA=;
        b=dX7XsLKdVagUMLtcBrpcMoJKqB1Yw5QVHwcVawHbdbXDMHsuuKMAxwM6Lp8nUmWbMw
         Hh8nMmETmlvvxS49stA2BItM0nGPcjph1SmvmSJeI5JObNPuIXsvgQvA3b2hNIFkTwMy
         AKnVU0Saig9XXlcLr70wB6FYSB3gMNxobuzpZIZ3AnG1MPKmXUKCiMoGnmgUKTOy52/X
         QRRKjtwSqf4cg2Fd6d+JP3sk4lawuAzSfuHBZiUbZOrVgo3EKbFa6MmvVJ0s90ghNCxv
         IPRXtLsMvkh6VVqxtP52foHD3cP25VPyZG6BveL1aJGcAFqWc/Fpx63nLyslH5yT4q0+
         87BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=buLwW9Upwu/0aO+lI2LypZ3xpXUVlEG3VMhVw7VQ4tA=;
        b=jDHaMDctxt6im3WSQux5Yh+DAx/0DwMp5UiDe6P8M0mlFT/3e/nsuw6AiArG68Z+Pc
         ZX6F4KUM2PtBZbyJmtED5/Tp7PSElQtfG/+7HX8Mpphy5cKRuLMLjguBvoWdiweQnng5
         uCCo/JB1ycpMWE3xKR80s2mbCe6HPBJHdRGS3pO6J506/VhqV0fl4Ae0jVqresl6HbHb
         9ed0DxyROy2swDwbPruOOH24G9GgC7Us8JfEdj4BYCMr9JpDcaMbnSZFTcWepjNzsGwU
         M3a664yNjvqg5z2gG/FZR/TGITlXWrn8owCzM96cGuTqHFFrrMLmLDvvnMus2xozsKQ+
         WQqA==
X-Gm-Message-State: APjAAAXd96rzkrtO0IXPuFQGfDQbdb8rrBw/g1fZsQr6D7KwkbCEwGP4
        Q5FHiq/dXSeuMEQ3yKSE9oWQ
X-Google-Smtp-Source: APXvYqyZMaSmPfryuxffFu9XVIDaj3367+BDwEu69W+82YdMuLOhWY63sSdE+IJew0VhRgP7AvRyOg==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr3238284pji.126.1570617823216;
        Wed, 09 Oct 2019 03:43:43 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id b73sm2213665pga.36.2019.10.09.03.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:43:42 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:43:36 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 7/8] ext4: reorder map.m_flags checks in
 ext4_set_iomap()
Message-ID: <20191009104334.GE14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <3551610e53aa1984210a4de04ad6e1a89f5bf0a3.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009063548.90C434203F@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009063548.90C434203F@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 09, 2019 at 12:05:47PM +0530, Ritesh Harjani wrote:
> You may be changing the function parameters & name here,
> (in ext4_set_iomap)

Hm, maybe. :P It all depends on the outcome of what we discuss in 1/8.

> But functionality wise the patch looks good to me.
> 
> You may add:
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Great, thanks Ritesh!

--<M>--
