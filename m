Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E712CC828
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbgLBUnJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 15:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbgLBUnI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 15:43:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C48C0617A7
        for <linux-ext4@vger.kernel.org>; Wed,  2 Dec 2020 12:42:27 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so6823219lfd.9
        for <linux-ext4@vger.kernel.org>; Wed, 02 Dec 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3btiNSHm6jRc+pdBtMLFUAxRzWlf/wPyv3Pzid5Qtc=;
        b=Z11LEqV8wdrsHfKnZ1gN+6MxuQLN4JBrl/ZQBEaq6vQOuLOGiyyvqkeCcPCYRhQDIv
         ZPmJT1ekDNw917/6qDlUXjz9Xu/yQOcMPNWuaxXaYoEorXu9QNfEuCP35vSG8m9tWndO
         8uCAyKVBZS5tHpQHBWAexF8LHzVQcFWUxGxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3btiNSHm6jRc+pdBtMLFUAxRzWlf/wPyv3Pzid5Qtc=;
        b=bWuL/33kns+YIh8vdSZLTJzVeLm7kdH+IbY2lBN8wwnRmFKozWKsHPfgEFt+WazdV+
         K1MQTNuvGtaJ+7vcxJo8AN8MmFozW9pMJ18oMoAoTSPA/NVUu4lp4/UBrInJY6EU8aaX
         xjaGdcFGeaFlfi7cimXCHatKBU+ZR1NRwN+dNlJU0H7C7QJTUiqs7JwzEmim7S/23yPY
         Nl+MgyNVslOjNiqQv3lGMqo6+JIHSt2zKJItz8T25Pvu8CJwIkG2YvMBqmG+t6zMk46A
         8zv7QJfYIv9pxWi+VZLWAAmuCBS9hiUn13v5Q1g/w8xwM8dXCP5M5VenaVb8VPUENDgx
         dwYw==
X-Gm-Message-State: AOAM532ADpm5qacS1zxo7b44pH/88I+IvLsFIJUzVacghqJQG1hynJmu
        zZapraS8eSyQKCxA69U9r0S+cJ3OwGNOow==
X-Google-Smtp-Source: ABdhPJyKLf5/hhJ+UKsndHVKGn2fdB+dhLSXfSKNTAk9jMlP+hGdUs8H0BtSS2s9ZhRmKiOYPoouSA==
X-Received: by 2002:ac2:514f:: with SMTP id q15mr2017301lfd.194.1606941745710;
        Wed, 02 Dec 2020 12:42:25 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 125sm802667lfe.171.2020.12.02.12.42.24
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 12:42:24 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id v14so6882706lfo.3
        for <linux-ext4@vger.kernel.org>; Wed, 02 Dec 2020 12:42:24 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr1907270lfy.352.1606941744281;
 Wed, 02 Dec 2020 12:42:24 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com> <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Dec 2020 12:42:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
Message-ID: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 1, 2020 at 6:16 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> This will force a change to xfstests at a minimum.  And I do know of users who
> have been using this value.  But I have gotten inquires about using the feature
> so there are users out there.

If it's only a few tests that fail, I wouldn't worry about it, and the
tests should just be updated.

But if there are real user concerns, we may need to have some kind of
compat code. Because of the whole "no regressions" thing.

What would the typical failure cases be in practice?

            Linus
