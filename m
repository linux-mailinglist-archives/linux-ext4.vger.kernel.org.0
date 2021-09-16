Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF56540EA4B
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhIPS4B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344965AbhIPSz6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 14:55:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D873C00EA8E
        for <linux-ext4@vger.kernel.org>; Thu, 16 Sep 2021 10:57:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso8143883pjj.0
        for <linux-ext4@vger.kernel.org>; Thu, 16 Sep 2021 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdm7aqM6cPmqGgmk/iB/fYKsk2wFX5hSUYjlnian/V4=;
        b=Eyd587gVkUJOeuq1UtFdEeW6oEl5ijLE0OtxmuuU5faC6M5PIHd5PMuD7qC4q47XVH
         mHCGrRYGsMuUO6TlKJPYW6JX93JxiViZ56k7UetqkzMxNsJsBJlRZANu/2f4Y3UrOE9N
         cutVTM1HNbsv0nzEM4kCBkpboj/7ncwVpTQ/Iu2vvQOgJccDpBvuZdlepx5GUrAFt0zM
         5w7depS/RIvCgt+2MSV1ClDP6rH/7nQAhBnt4vgtAgWTNAkVOp48Uy/d/yk7e8G+p3kw
         MWDXTFdWA1KFthL1rwiB4Xzfw4OzVE1CXD6np/jodb4kQSsdyXRLpPyzZrjpA2agVapn
         ODRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdm7aqM6cPmqGgmk/iB/fYKsk2wFX5hSUYjlnian/V4=;
        b=2sblcjS9BxyWuJhZHqjLqVSUQFiTnZfmJ6PEBDgHt21rUEUV6p3kehtU4nky8/Fr9P
         Sl3rZIufIPFrnSej8Ieu/vBZ5FipGMiQYY7sSn7Vu98UV8laDnA01nbOYtXud8rFDwjg
         gxJ9BuG4WQpoj44r/qSvcc+oMfbQcpoIvImMn6I38y97jrajJTZAVKweGaCEiRA59yBw
         T4D7v4rF1IemL+N3ux/upiVW2DKVwb1CF/a/V5yTGUWNNwjJD0vt1YbD6xZI4BF66tDY
         zCnvyoebUch14amDd+yGGFJr0zUNgx/1kAAIbQBZ+g+jCMJMNqP4iYEtGAF+fy7PE4+A
         XAIw==
X-Gm-Message-State: AOAM530oi7pP+X+UEwOmXtfNwuFhBEdckTMw6rjxMjAOkhTdr590VMb6
        RDhqDjOpEiWSbbd5rGWgQcLh6+LHjnY=
X-Google-Smtp-Source: ABdhPJyNwyl5YcJKzAFNrZAs2W4pC9RnlLgO2w5ZuBkkTLpuV1RGOyw86vkdwIrd6Slrqq6Ny8eobA==
X-Received: by 2002:a17:90b:1807:: with SMTP id lw7mr3715544pjb.217.1631815076538;
        Thu, 16 Sep 2021 10:57:56 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:7868:d0fe:c210:2ee])
        by smtp.gmail.com with ESMTPSA id m26sm3799591pfo.146.2021.09.16.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:57:56 -0700 (PDT)
Date:   Thu, 16 Sep 2021 10:57:53 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/3] resize2fs: attempt to keep the # of inodes valid by
 removing the last bg
Message-ID: <YUOFoTVNEddokU4A@google.com>
References: <20210914191104.2283033-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191104.2283033-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good to me. Series compiled and ran without any test regressions
for me. Some lines are over 80 chars though, could wrap.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
