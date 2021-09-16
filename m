Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55CF40EA4C
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbhIPS4T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbhIPS4E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 14:56:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59740C03D745
        for <linux-ext4@vger.kernel.org>; Thu, 16 Sep 2021 11:00:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso8147753pjj.0
        for <linux-ext4@vger.kernel.org>; Thu, 16 Sep 2021 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXfn57PcLqlyy158clNaENgBFHWjUWw99uFViGh5H28=;
        b=mHdFjAhd4Rk2kbPJiqS0FQud8ldr7qZSo62dT9F+h9GWmpqQ0rxYrlgsdqntvf2WKN
         2DFRbmiha9/p2+buZIERCi5N/wg9tZUw+KFcY3YKIg/1oX7freqpuoSuG857zNlE5rAt
         Yy4qxhL8gzQpjvaw73YVluhgNbXl5BrUl6kexc5gg6lT/RwPpZtcrXd1+5kCtEyhxypu
         3wTXAKN55hWuYoJRASt0jw5Lw5soy6OwogDpVMOruk+7Q1gXVPcEK+cD5Xggz4ybRPDQ
         riHP2Motdl02/QxQL7R42dvAMBtsAEdJtDhH+14D/nrDuFUa2TtDbFYFCJhD4nztsECF
         pq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXfn57PcLqlyy158clNaENgBFHWjUWw99uFViGh5H28=;
        b=B/G16vgL/QoC/0y+1+kGw3Eic3FBb37+58s/HyhQXtlsQrQpEIHZH/blvWBc5bBWg2
         U/cMqSJDq6696AX51Ooc1MvGwHzEyABjxFnJhvFxoPaqNHFhyLTXrxLtCNPH8pSJPHXS
         TO1chOKsjD4Sj3aYjC7XtBcG5gsQTd58GraIaxXEoWddXMDO73GjankGgZADB53vx51r
         6Qj6gU233D0xhD5IaPmxD/8cdLL7TzBSYH2wuSwcOTHQPWLf3vDcMKmmw5QJeZ5IZMxf
         U4N3Ia+blSrHmY+cjUSrOZOQxrT6AmwyC4+p5yh+tXlZoAH7XV4NYi+Gmage8ztbZ57g
         MEZw==
X-Gm-Message-State: AOAM533si8Kan42QOQnNfpS9nX5uARh/2e7S0fU/wMamLtvcvxc9sCgB
        70hnPB0QxxvzzUfiK2rqOKI=
X-Google-Smtp-Source: ABdhPJy+AJ68Tmoi17hzcO5d6AwMJBSZEgQRFq2eXI1I26WJJGT8mzfY2vVPK7n8K/UyNjJBUWAbHA==
X-Received: by 2002:a17:90b:124c:: with SMTP id gx12mr7570031pjb.106.1631815200820;
        Thu, 16 Sep 2021 11:00:00 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:7868:d0fe:c210:2ee])
        by smtp.gmail.com with ESMTPSA id p9sm4374822pgn.36.2021.09.16.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:00:00 -0700 (PDT)
Date:   Thu, 16 Sep 2021 10:59:58 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/3] resize2fs: adjust new size of the file system to
 allow a successful resize
Message-ID: <YUOGHhHV9LHmjm4L@google.com>
References: <20210914191104.2283033-1-tytso@mit.edu>
 <20210914191104.2283033-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191104.2283033-2-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
