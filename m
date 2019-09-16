Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3BB3AC2
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfIPMxU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 08:53:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44557 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732709AbfIPMxU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 08:53:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so19768489pgl.11
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJYJFM/Q/O8KCi3hF19Zx6Yw3YMNVDSIL1QMzh6ZZ5I=;
        b=W4usgsb7XXHacpAoquAX4WfXTwndcwoKV76Azx7+s8A4uRc6neRN9uihS1ZHPL8cpd
         eMPR74J5RU+4f80639uGv5pi+uuaItd2fI/d6vdCav6+6wAryNDEgZmrv30FhUpuHuJy
         nG91JlCx9HRFflwBNTQ32y6RGPR8MTbEvT5tEjSo56nXrH0qML3yaQIJwldAMyD74eqL
         oVvRhv41dvGs00ePCQBbgJmbfcxV4ztSkNhqPGaF71dGDkG6aAKhn8tqMQZOiAgRV66p
         cTbD24j9nayB8bGisgXSMPLvRZ9gr1dSxTbycxfEBMRS1NqMggIoERh7NXVVPL9zr7mN
         BzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJYJFM/Q/O8KCi3hF19Zx6Yw3YMNVDSIL1QMzh6ZZ5I=;
        b=O+Gz+VnwaxJ+MQTeC7snXCdjX5Uty0AwBfACncfeI2Iy7hoK290OJd5CvAGrr8PwIs
         5gOczBW6Hj1XDN/5MA/4GKPtVz8s5t4vudEgDmqkie8efjwD3DP0ZyZi0LA12pzujH9x
         gRxxc9mTsmB3Y9eEx0rvA0gCvlyeUDI+kGT8QBYbr1YamsByjCezV+ZfjNGib465kUqY
         IRijCxsLp3yHZya1nKW/XoOUB2Z5L9b0KleLk7GAJ9af3Ubg9EDsl3iebogUGoD5XyWO
         f6tSOYQD7+tE7apgtHbf6Tpc2adUpd33LAEaPQPekb8Jqq97x+sClcTsiMhpSKRhCItM
         1uCQ==
X-Gm-Message-State: APjAAAXc91ryPn1qmbIi2OcCes74oz6aO4p46+S5nIcu7QwBFcfsuxVv
        BexM7bmhsxUIWddF1YQ20HeZ
X-Google-Smtp-Source: APXvYqzjACRpVyZJfkp5gG5GDDBnZZ+u5/+W2hz3bIAv6x7Fe0D9Z+q0ymw8TsqwKLOa3ofC+CeZXA==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr55117967pgl.270.1568638399033;
        Mon, 16 Sep 2019 05:53:19 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id b3sm57723721pfp.65.2019.09.16.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:53:18 -0700 (PDT)
Date:   Mon, 16 Sep 2019 22:53:12 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v3 6/6] ext4: cleanup legacy buffer_head direct IO code
Message-ID: <20190916125312.GC4024@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <1d83ac7f8088837064b90cfb3182a37b46356239.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916120632.GC4005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916120632.GC4005@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 05:06:32AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 12, 2019 at 09:05:03PM +1000, Matthew Bobrowski wrote:
> > Remove buffer_head direct IO code that is now redundant as a result of
> > porting across the read/write paths to use iomap infrastructure.
> 
> I still think moving the removal of the not required code into the
> actual patches that make the code obsolete is a better idea.  That
> makes it very clear what is added to remove what kind and amount of
> old code.

Yeah, you're right, I completely agree with that now that you mention it. I
will do this for the next version of this patch series.

--<M>--
