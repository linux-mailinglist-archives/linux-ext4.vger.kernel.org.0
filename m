Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693F4484E54
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 07:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiAEGWv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 01:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiAEGWv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 01:22:51 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF77C061761;
        Tue,  4 Jan 2022 22:22:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id x194so11493801pgx.4;
        Tue, 04 Jan 2022 22:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgVjBJ/RRJcRn0r1MHCMgSgawIjKINoGhHmSB/I+8xY=;
        b=SK4X6Depc5zPs+xCkjz1r1ONVRV3TJJvOTHVlIXxq6gYYoQliT13rZBEZJINn3c8m2
         hu8fTrBuk+5TfRXKf+JCSjLZyxKx9da0pd8B3EzIlYCz/ugtlY3SbXwX5QpHu3afWXXY
         jmH+9UPFdwgFAfyj+LDT2WxTEg73ErIB6OjEu2/IDH2YO1ZIRgHE17N6nacJih5ErKIJ
         fUUWgmzLzvDFO7iLPQ4qlWUypizg4n+N+RyIBxyQJdmv7lzFqm0D3i1JCK+qzIc2r4UV
         RRYLpbH/lqJdey78fjKBglGAGJqyMhkedYcjGWs8RWZTStO8mOHT/BlDh3bSpgZfp2Cs
         CMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgVjBJ/RRJcRn0r1MHCMgSgawIjKINoGhHmSB/I+8xY=;
        b=SDmKRW8M+rQ1WSg1s8D3NALA3uvxB3ne2niJPAVl1+Sso8FhurVIK9S918m7vUclmU
         KRR6dULP7j32g913RMoqszcTbdXXfM9sqf7wbOGYMtap4Iqh3/lSvfRyx/lyvVcuTiSP
         t1U+oUEiFmoeD3Qd35WFG/UbkX7joaOvPF/rKZ2jhO5cUgj5fJoGPfShc4eKvDtyn9dF
         YkF/w4DyAkiLH3v9n8T335g0S+mFkEiNPlZiUJ1JxUzUyzSNV2Cbm5a0HqcwbgGI19YT
         ChcfNPluKkHYsxdMs1/Ws7UEAZ1yHH32gTJVdM++zPBMh/O0f1bRFSfGsNtOpuqumdBb
         k0FQ==
X-Gm-Message-State: AOAM530JnouI1G7PxbOlqh51GULNqCFe+99EyxJgKHdQvgWTIgZ5X9Go
        xDLqUuiqOeET8nHL9nfo3K8=
X-Google-Smtp-Source: ABdhPJzNlVkNSkd32XrerWep/X4x0Y2gJqkPCQAlFO+JOCRmdboDnnDXXbhLDUrowoyMRUVrdtH2mQ==
X-Received: by 2002:a63:3d8a:: with SMTP id k132mr46880216pga.577.1641363770919;
        Tue, 04 Jan 2022 22:22:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ls7sm1194402pjb.11.2022.01.04.22.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 22:22:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     riteshh@linux.ibm.com
Cc:     adilger.kernel@dilger.ca, cgel.zte@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, xu.xin16@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH resend] fs/ext4: use BUG_ON instead of if condition followed by BUG
Date:   Wed,  5 Jan 2022 06:22:46 +0000
Message-Id: <20220105062246.604558-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105053522.ql7hg3luxn6gsp7m@riteshh-domain>
References: <20220105053522.ql7hg3luxn6gsp7m@riteshh-domain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>While we are at it, I feel correcting below BUG() in the same patch(es?)
>might be useful too.

I agree with it.

Feel free if you're willing to do the integration of patches.



