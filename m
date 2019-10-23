Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9AE17B3
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfJWKUW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 06:20:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38677 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390361AbfJWKUW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Oct 2019 06:20:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so9866250plq.5
        for <linux-ext4@vger.kernel.org>; Wed, 23 Oct 2019 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=famTCWyPOGlr1iiTRrbj7To+YO5ZL7PQ7fuU9NIRIM8=;
        b=JON2hb8FD7wKKKxya3rkN1coe2W2La6b76N2w7fZYQuMexSyKUaAgkW4Y3KrdrmU+b
         uyC7JgtXzwGZzYqla2Z48CaVnxDTKZn9juyVEPKg2yJnmbz7df8WrnL66WfZE6qSYPAX
         LhHXe1DcWo8YeWiE62X5KTyEBoCPW4UwwdqiatwvKKntKxjCRKcyBLF9zg05NltG6YYU
         APFD+N0vyOClP5deqSULDlcl2Voqw4pstFpbIujruRlfNuXCA6N3EZdRyt86yULLZD7C
         PECJaj+S67lZmRj6AemJBqeM2n/wR+C2ce0YqFCLOP7OTnn0mDj3eovs0tuTrGX+oD7t
         f3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=famTCWyPOGlr1iiTRrbj7To+YO5ZL7PQ7fuU9NIRIM8=;
        b=Fm384MKg2vGJB9SfYna0JEt68G7tU+82NgTCj23r3SiSY+XpoTOjS0COUQAsByEfmW
         F/1tY6D0cvcHJaha3qE7Nl9Bp5FxWk25BM7+k9Fn0c3FzsZlKQHB93u6Kwofq8i6oLQy
         6t42m1Je36PVn4FA8A8eH3VPJzS9EuUPf0zQSgFU3+9u5eYIg4RyWkbOfG52WHAQAZLF
         iEsXDU4HsD6IIFduAuc2Yh90mLUDOhkUAWLv47q2TXtPlJyVXUCMXci5X/AC4plWY5CI
         34dHzbFRgpy0x5hdiMPd7eW5DOxDWc2Vl/BMfEukWvHXB+iXDLJqcF02upoz8MCQ0hRk
         VrVg==
X-Gm-Message-State: APjAAAV69/0r410auktBqBcwWQ7U8TgpdBrmUMDuesPhfRiVCpYcjm3S
        lQPtPefj2QP99pbOB7JvALImDKJQ5Jlm
X-Google-Smtp-Source: APXvYqx/Gh/865ymI26LBSmTesvR7Y1bh+ywON7c0JxKZnQK2Be6SXoP+jYM1TCdeWFIWd4Wpb2yfw==
X-Received: by 2002:a17:902:8343:: with SMTP id z3mr8789394pln.70.1571826021159;
        Wed, 23 Oct 2019 03:20:21 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id w2sm16327287pgm.18.2019.10.23.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:20:20 -0700 (PDT)
Date:   Wed, 23 Oct 2019 21:20:14 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 02/12] ext4: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191023102014.GC6725@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
 <20191023063557.21C964C050@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023063557.21C964C050@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 12:05:55PM +0530, Ritesh Harjani wrote:
> On 10/21/19 2:47 PM, Matthew Bobrowski wrote:
> > This patch is effectively addressed what Dave Chinner had found and
> > fixed within this commit: 8a23414ee345. Justification for needing this
> > modification has been provided below:
> Not sure if this is a valid commit id. I couldn't find it.

Ah, oops! I plucked that from somewhere, but where (some thread)? Hm, anyway,
this is what I was referring to:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=xfs-5.5-merge&id=7684e2c4384d5d1f884b01ab8bff2369e4db0bff

This is queued for 5.5, so I will add this commit hash to my changelog in v6.
 
--<M>--
