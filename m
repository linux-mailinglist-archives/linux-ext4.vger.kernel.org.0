Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C951DDB89
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 02:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgEVABH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 20:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgEVABG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 May 2020 20:01:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1415AC061A0E
        for <linux-ext4@vger.kernel.org>; Thu, 21 May 2020 17:01:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so10498058ljc.8
        for <linux-ext4@vger.kernel.org>; Thu, 21 May 2020 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbo7f9Gr3cg/KLt/kOvWotZglXfgKin96QcbEfg0Yl0=;
        b=TFdXsMqAMyMKk9ye8tn2O/u/rQLmivp7qkkUkjoGIuirsDa5u7y7VK/iAP5npzCGm4
         DrEjofrl+c2jqHiQGxbMu0kLgifgYnjy4EIk0TIi/3hnmC38lqS6wf6XraHA3KxElkdH
         rTo0K9NG6zdBb/ImWn4JBhqPb7/fqXrQNHsYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbo7f9Gr3cg/KLt/kOvWotZglXfgKin96QcbEfg0Yl0=;
        b=c1GVfs8wWVUuaE3KsDGg16mKRZKXtUWzxrWT0pG2pTqv+yjKAIVyT+lJp4jB0Y4RPP
         OyEZ8datNGdRgrvjOxQH6OM9TMCsgQXcmwLldK68UXiPAt6jHxapwE8lizispPTrula9
         70qG0eCO8weRBbHIYV6s0z4ZY+MWxSx/u3xP7LTiAWvDkVp4f5VzcwVoo/WprKVvCBg6
         1U08FJfaMkazfHq59c7cp2c72GZhXlEn65W6uIJ0W4LVB5RL+rp2Rg/QCIb8Wjhb0Bu3
         PUwxkWk0lOIt64G166/tIvCmlAIrmnxevKE5YodPdEJ5D5ewOwBCdrL/Wry4/mCM8gUD
         oEEQ==
X-Gm-Message-State: AOAM531PDfdduSJiTtsdHSqd3icR0Smc+WMQ4wmvZPNIhS4BpOZdDH1j
        Q8D+Hpkv7JXDOorza+pv2XtYo3oewLs=
X-Google-Smtp-Source: ABdhPJwFGvvN9tO/YzL17GLqlzbM8eeZmP62yUc/ZMKoyL2W23f27+pU9a0ulQkJxaJ3AT3C6GvOuQ==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr6042140ljh.274.1590105663214;
        Thu, 21 May 2020 17:01:03 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h6sm2026607ljj.29.2020.05.21.17.01.01
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 17:01:02 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id o14so10529758ljp.4
        for <linux-ext4@vger.kernel.org>; Thu, 21 May 2020 17:01:01 -0700 (PDT)
X-Received: by 2002:a2e:9891:: with SMTP id b17mr4329530ljj.312.1590105661602;
 Thu, 21 May 2020 17:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200505154324.3226743-1-hch@lst.de> <20200507062419.GA5766@lst.de>
 <20200507144947.GJ404484@mit.edu> <20200519080459.GA26074@lst.de> <20200520032837.GA2744481@mit.edu>
In-Reply-To: <20200520032837.GA2744481@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 17:00:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUM=bB4Ojz+km9aAtWC9TPtcNXANk32XCPm=yZ-Pi2MA@mail.gmail.com>
Message-ID: <CAHk-=wgUM=bB4Ojz+km9aAtWC9TPtcNXANk32XCPm=yZ-Pi2MA@mail.gmail.com>
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        adilger@dilger.ca, Ritesh Harjani <riteshh@linux.ibm.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ted's pull request got merged today, for anybody wondering..

Christoph, can you verify that everything looks good?

          Linus

On Tue, May 19, 2020 at 8:28 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> I'll send it to Linus this week; I just need to finish some testing
> and investigate a potential regression (which is probably a flaky
> test, but I just want to be sure).
