Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C156136462
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2020 01:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgAJAax (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 19:30:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37354 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgAJAaw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jan 2020 19:30:52 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so222528pjb.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jan 2020 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=WU93w3AtbVDPqYWtjAM3MuAwVxoBZV4OjJfby5UWG0k=;
        b=1tZqDa5G0PuPlzu1UjJOEgvTaHSV+roJwZ7hvUYGjH6N+5+UZ75ROicgm6XrVTC01k
         OMn6l5Gm1UNk3V4jMxJBS3RxSWRzp4+OmamHgL56pd4uQMxR7dPLcH/PYEijw9pJXMpF
         BylAvmBwoL9jvFw4t1L6iApg5dOlUoTP9Td6VkEZKd7Cb+qcBRTDCHT0XP/o+PGXeQ+M
         aoVUsJMunUjg7ZjguTqJbaK+ZuZYUrkIlqiUcW4p/YIGQqAJKPejy+NqofKOApJrZIcV
         V1peHznnppNnEpDN4/cbmUJzqIIVRCz1bfjQ9lTtQC1Sk1kurVw8HhffEOWTivtlRze7
         eHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=WU93w3AtbVDPqYWtjAM3MuAwVxoBZV4OjJfby5UWG0k=;
        b=ooE2liprL7+lmHNB0CsmpsgdO7S2xx8HpoqeLqWh3cRhD4W5mgiOKf/nDa4OEI2KcM
         bCiEUvJxuJm+UKtn1c+oAi9wWauPJT7/ZphdbrAdKzHh7F8AsWg2LfgyhbyaHtFfVRDY
         o4Oawi7srUJAVT3fvVByRxOhOceOi+dw4e1HEshsWPGVyGi6JuPNK9xm2FYHb31TG4GR
         N4fnPgPfiW2CeFK7sFYmWVt0ui34IHN2Ii/eMYN00JqBEwR1iYoaUpQ/noZ+JMxVRMZH
         XkdCSoZkq+E1liEEe32TDbA8nfa87yXCrJiFPONKeVxHLtaxDnbeAipOqlcucjvgpb4K
         k71g==
X-Gm-Message-State: APjAAAVMEY2MJfFG6YksiNXNvCmtUBHP35OsG7a2lch1cZC+2qMHXJFl
        p5Ki3vo2p+rPHO+9rlhi9nRC3/ZjGAQ=
X-Google-Smtp-Source: APXvYqyNkS0EsFX1UycczKNVnCf9IxzBAT68JzKuVVbY09Lf8pIIJ3g6/yVhwwDOQ77iPPekM2G+hw==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr1029789pjk.26.1578616251644;
        Thu, 09 Jan 2020 16:30:51 -0800 (PST)
Received: from [10.197.30.113] ([139.104.2.240])
        by smtp.gmail.com with ESMTPSA id 83sm121404pgh.12.2020.01.09.16.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 16:30:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/8] Rework random blocking
Date:   Thu, 9 Jan 2020 14:30:48 -1000
Message-Id: <99CB981B-752C-449B-98BE-A4DF80D25A26@amacapital.net>
References: <20200109220230.GA39185@roeckx.be>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <20200109220230.GA39185@roeckx.be>
To:     Kurt Roeckx <kurt@roeckx.be>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Jan 9, 2020, at 12:02 PM, Kurt Roeckx <kurt@roeckx.be> wrote:
>=20

>=20
> If the kernel provides a good RNG, the only reason I can see why
> you would like to have direct access to a hwrng is to verify that
> it's working correctly. That might mean that you put it in some
> special mode where it returns raw unprocessed values. If the device
> is in such a mode, it's output will not provide the same entropy
> per bit, and so I would expect the kernel to stop using it directly.

I disagree.

If I buy a ChaosKey or a fancy EAL4FIPSOMG key, I presumably have it for a r=
eason and I want to actually use the thing for real. Maybe it=E2=80=99s for s=
ome certification reason and maybe it=E2=80=99s just because it=E2=80=99s re=
ally cool.

As for =E2=80=9Cdirect=E2=80=9D access,  I think AMD provides an interface t=
o read raw output from the on-die entropy source. Exposing this to user spac=
e is potentially quite useful for anyone who wants to try to characterize it=
.  I don=E2=80=99t really think people should use a raw sample interface as a=
 source of production random numbers, though.
