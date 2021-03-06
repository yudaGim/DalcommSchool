package dcsc.mvc.domain.coupon;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

import dcsc.mvc.domain.classes.Classes;
import dcsc.mvc.domain.user.Teacher;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor

public class Coupon {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "coupon_id_seq")
	@SequenceGenerator(sequenceName = "coupon_id_seq", allocationSize = 1, name = "coupon_id_seq")
	private Long couponId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "teacher_id")
	@JsonIgnore
	private Teacher teacher;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "class_id")
	@JsonIgnore
	private Classes classes;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "coupon_state_id")
	@JsonIgnore
	private CouponState couponState;

	private String couponName;
	private int couponDc;
	
	@CreationTimestamp
	private LocalDateTime couponInsertDate;
	
	@UpdateTimestamp
	private LocalDateTime couponUpdateDate;
	
	private Integer couponEndDate;
	
}
